.PHONY: ALWAYS

all:
	# nothing

generate: generate_basics generate_packages generate_private_types ALWAYS

generate_basics: ALWAYS
	adacut -m question src/050_array_types/template/array_types_main.adb > src/050_array_types/src/array_types_main.adb
	adacut -m answer src/050_array_types/template/array_types_main.adb > src/050_array_types/answers/array_types_main.adb
	adacut -m question src/060_record_types/template/record_types_main.adb > src/060_record_types/src/record_types_main.adb
	adacut -m answer src/060_record_types/template/record_types_main.adb > src/060_record_types/answers/record_types_main.adb
	adacut -m question src/070_subprograms/template/subprograms_main.adb > src/070_subprograms/src/subprograms_main.adb
	adacut -m answer src/070_subprograms/template/subprograms_main.adb > src/070_subprograms/answers/subprograms_main.adb

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

