.PHONY: ALWAYS

all:
	# nothing

generate: ALWAYS
	adacut -m question src/050_array_types/template/array_types_main.adb > src/050_array_types/src/array_types_main.adb
	adacut -m answer src/050_array_types/template/array_types_main.adb > src/050_array_types/answers/array_types_main.adb
	adacut -m question src/060_record_types/template/record_types_main.adb > src/060_record_types/src/record_types_main.adb
	adacut -m answer src/060_record_types/template/record_types_main.adb > src/060_record_types/answers/record_types_main.adb
	adacut -m question src/070_subprograms/template/subprograms_main.adb > src/070_subprograms/src/subprograms_main.adb
	adacut -m answer src/070_subprograms/template/subprograms_main.adb > src/070_subprograms/answers/subprograms_main.adb
