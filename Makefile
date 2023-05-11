.PHONY: ALWAYS

all:
	# nothing

generate: ALWAYS
	adacut -m question src/050_array_types/template/array_types_main.adb > src/050_array_types/src/array_types_main.adb
	adacut -m answer src/050_array_types/template/array_types_main.adb > src/050_array_types/answers/array_types_main.adb
