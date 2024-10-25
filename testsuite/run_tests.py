from argparse import ArgumentParser
from pathlib import Path
import difflib
import os
import subprocess
from epycs.subprocess import cmd, find_program, python_to_subprocess


ROOT = Path(__file__).resolve().parents[1]
BIN = ROOT / "bin"
TSV_TESTS = ROOT / "testsuite" / "tests_TSV"


def list_all_labs_options():
    with open(ROOT / "labs_solar_system.gpr.Lab.options") as f:
        return f.read().splitlines()


def build(o):
    for f in BIN.glob("*"):
        # ugly: we have to cleanup the binary directory to get
        # the executable name
        if f.is_file():
            f.unlink()

    rc = cmd.alr(
        "build",
        additional_env={"Lab": o, "Mode": "Answer", "Backend": "TSV"},
        check=False,
    ).returncode
    if rc == 0:
        exe_name = next(iter(f for f in BIN.glob("*") if f.is_file()))
    else:
        exe_name = None
    return rc, exe_name


def run_for(exe_name, n):
    exe = find_program(exe_name)
    running_lab = exe(stdout=subprocess.PIPE, background=True)
    res = cmd.head(
        "-n", n, stdout=subprocess.PIPE, stdin=running_lab.stdout, check=False
    )
    running_lab.kill()
    return res.returncode, res.stdout


def compare(*, expected_ln, actual_ln):
    return list(
        difflib.unified_diff(
            fromfile="expected", a=expected_ln, tofile="actual", b=actual_ln
        )
    )


def main():
    ap = ArgumentParser()
    ap.add_argument("--save-baseline", action="store_true")
    args = ap.parse_args()

    must_save_baseline = args.save_baseline

    for o in list_all_labs_options():
        expected_p = TSV_TESTS / f"{o}.expected.out"
        if expected_p.is_file():
            with open(expected_p) as expected_f:
                expected_ln = expected_f.read().splitlines()

            print("Test", o)
            rc, exe_name = build(o)
            if rc != 0:
                print("ERROR: BUILD", o)
            else:
                rc, actual = run_for(exe_name, len(expected_ln))
                if rc != 0:
                    print("ERROR: RUN", o)
                else:
                    actual_ln = actual.splitlines()
                    res = compare(expected_ln=expected_ln, actual_ln=actual_ln)
                    if len(res):
                        print("FAIL:", o)
                        print(os.linesep.join(res))
                        if must_save_baseline:
                            with open(expected_p, "wt") as baseline_f:
                                baseline_f.write(actual)
                            print("(baseline saved)")
                    else:
                        print("success:", o)
        else:
            print("skip", o)


if __name__ == "__main__":
    main()
