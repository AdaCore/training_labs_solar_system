.PHONY: ALWAYS

all: doc_html alr_build

doc_html: ALWAYS
	make -C doc html

alr_build: ALWAYS
	alr build

edit: alr_build ALWAYS
	alr edit

run: ALWAYS
	alr run

generate: \
	generate_basics \
	generate_packages \
	generate_private_types \
	generate_access_types \
	generate_genericity \
	generate_interfacing_with_c \
	generate_tasking_protected_objects \
	generate_subprogram_contracts \
	ALWAYS

generate_basics: ALWAYS
	adacut -m question src/050_array_types/template/array_types_main.adb > src/050_array_types/src/array_types_main.adb
	adacut -m answer src/050_array_types/template/array_types_main.adb > src/050_array_types/answers/array_types_main.adb
	adacut -m question src/060_record_types/template/record_types_main.adb > src/060_record_types/src/record_types_main.adb
	adacut -m answer src/060_record_types/template/record_types_main.adb > src/060_record_types/answers/record_types_main.adb
	adacut -m question src/070_subprograms/template/subprograms_main.adb > src/070_subprograms/src/subprograms_main.adb
	adacut -m answer src/070_subprograms/template/subprograms_main.adb > src/070_subprograms/answers/subprograms_main.adb
	adacut -m question src/190_exceptions/template/solar_system.adb > src/190_exceptions/src/solar_system.adb
	adacut -m answer src/190_exceptions/template/solar_system.adb > src/190_exceptions/answers/solar_system.adb

template_packages := $(wildcard src/100_packages/template/*.ad?)
generate_packages: $(template_packages)
	for f in $^; do \
		adacut -m question $$f > src/100_packages/src/$$(basename $$f); \
		adacut -m answer $$f > src/100_packages/answers/$$(basename $$f); \
	done

template_private_types := $(wildcard src/110_private_types/template/*.ad?)
generate_private_types: $(template_private_types)
	for f in $^; do \
		adacut -m question $$f > src/110_private_types/src/$$(basename $$f); \
		adacut -m answer $$f > src/110_private_types/answers/$$(basename $$f); \
	done

template_access_types := $(wildcard src/140_access_types/template/*.ad?)
generate_access_types: $(template_access_types)
	for f in $^; do \
		adacut -m question $$f > src/140_access_types/src/$$(basename $$f); \
		adacut -m answer $$f > src/140_access_types/answers/$$(basename $$f); \
	done

template_genericity := $(wildcard src/160_genericity/template/*.ad?)
generate_genericity: $(template_genericity)
	for f in $^; do \
		adacut -m question $$f > src/160_genericity/src/$$(basename $$f); \
		adacut -m answer $$f > src/160_genericity/answers/$$(basename $$f); \
	done

template_interfacing_with_c := $(wildcard src/230_interfacing_with_c/template/*.ad?)
generate_interfacing_with_c: $(template_interfacing_with_c)
	for f in $^; do \
		adacut -m question $$f > src/230_interfacing_with_c/src/$$(basename $$f); \
		adacut -m answer $$f > src/230_interfacing_with_c/answers/$$(basename $$f); \
	done

template_tasking_protected_objects := $(wildcard src/adv_240_tasking_protected_objects/template/*.ad?)
generate_tasking_protected_objects: $(template_tasking_protected_objects)
	for f in $^; do \
		adacut -m question $$f > src/adv_240_tasking_protected_objects/src/$$(basename $$f); \
		adacut -m answer $$f > src/adv_240_tasking_protected_objects/answers/$$(basename $$f); \
	done

template_subprogram_contracts := $(wildcard src/adv_270_subprogram_contracts/template/*.ad?)
generate_subprogram_contracts: $(template_subprogram_contracts)
	for f in $^; do \
		adacut -m question $$f > src/adv_270_subprogram_contracts/src/$$(basename $$f); \
		adacut -m answer $$f > src/adv_270_subprogram_contracts/answers/$$(basename $$f); \
	done

build_solutions:
	set -e; \
    for lab in "Array_Types" "Record_Types" "Subprograms" "Packages" "Private_Types" "Access_Types" \
	"Exceptions" "Interfacing_With_C" "Tasking_Protected_Objects" "Subprogram_Contracts"; do \
		echo $$lab; \
		Mode=Solution Lab="$$lab" alr build; \
	done
