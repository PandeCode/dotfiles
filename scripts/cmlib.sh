GNU_ENV='CC=gcc CXX=g++'
CLANG_ENV='CC=clang CXX=clang++'

cmgv() {
	cmake -D CMAKE_BUILD_TYPE=$1 -D CMAKE_EXPORT_COMPILE_COMMANDS=ON -S . -B $1 &&
		ln -s ./MinSizeRel/compile_commands.json ./compile_commands.json &&
		compdb -p . list > __new__compile__ && mv __new__compile__ compile_commands.json
}

cmb() {
	cmake --build $1
}

runCommand() {
	case $1 in

		"Init")
			mkdir -p src include
			touch CMakeLists.txt src/main.cpp
			;;

		"Clean") rm -fr CMakeCache.txt \
			cmake_install.cmake Makefile CMakeFiles compile_commands.json build/ Debug/ Release/ MinSizeRel/ RelWithDebInfo/ ;;

		"CLI Template") ls ~/dev/cpp/Templates ;;
		"CLI httplib Template") ls ~/dev/cpp/Templates ;;
		"CLI crow Template") ls ~/dev/cpp/Templates ;;
		"CLI websocketpp Template") ls ~/dev/cpp/Templates ;;
		"GUI Qt Template") ls ~/dev/cpp/Templates ;;
		"SFML Template") ls ~/dev/cpp/Templates ;;

		"Generate Debug") cmgv Debug ;;
		"Generate Release") cmgv Release ;;
		"Generate RelWithDebInfo") cmgv RelWithDebInfo ;;
		"Generate MinSizeRel") cmgv MinSizeRel ;;

		"Clang Generate Debug") $CLANG_ENV cmgv Debug ;;
		"Clang Generate Release") $CLANG_ENV cmgv Release ;;
		"Clang Generate RelWithDebInfo") $CLANG_ENV cmgv RelWithDebInfo ;;
		"Clang Generate MinSizeRel") $CLANG_ENV cmgv MinSizeRel ;;

		"GNU Generate Debug") $GNU_ENV cmgv Debug ;;
		"GNU Generate Release") $GNU_ENV cmgv Release ;;
		"GNU Generate RelWithDebInfo") $GNU_ENV cmgv RelWithDebInfo ;;
		"GNU Generate MinSizeRel") $GNU_ENV cmgv MinSizeRel ;;

		"Build Debug") cmb Debug/ ;;
		"Build Release") cmb Release/ ;;
		"Build RelWithDebInfo") cmb RelWithDebInfo/ ;;
		"Build MinSizeRel") cmb MinSizeRel/ ;;

		"Clang Build Debug") $CLANG_ENV cmb Debug/ ;;
		"Clang Build Release") $CLANG_ENV cmb Release/ ;;
		"Clang Build RelWithDebInfo") $CLANG_ENV cmb RelWithDebInfo/ ;;
		"Clang Build MinSizeRel") $CLANG_ENV cmb MinSizeRel/ ;;

		"GNU Build Debug") $GNU_ENV cmb Debug/ ;;
		"GNU Build Release") $GNU_ENV cmb Release/ ;;
		"GNU Build RelWithDebInfo") $GNU_ENV cmb RelWithDebInfo/ ;;
		"GNU Build MinSizeRel") $GNU_ENV cmb MinSizeRel/ ;;

		*)
			echo "Unknown"
			;;
	esac
}
getPreview() {
	case $1 in

		"Init") echo "Init" ;;
		"Clean") echo "Clean" ;;
		"Generate Debug") echo "Generate Debug" ;;
		"Generate Release") echo "Generate Release" ;;
		"Generate RelWithDebInfo") echo "Generate RelWithDebInfo" ;;
		"Generate MinSizeRel") echo "Generate MinSizeRel" ;;
		"Clang Generate Debug") echo "Clang Generate Debug" ;;
		"Clang Generate Release") echo "Clang Generate Release" ;;
		"Clang Generate RelWithDebInfo") echo "Clang Generate RelWithDebInfo" ;;
		"Clang Generate MinSizeRel") echo "Clang Generate MinSizeRel" ;;
		"GNU Generate Debug") echo "GNU Generate Debug" ;;
		"GNU Generate Release") echo "GNU Generate Release" ;;
		"GNU Generate RelWithDebInfo") echo "GNU Generate RelWithDebInfo" ;;
		"GNU Generate MinSizeRel") echo "GNU Generate MinSizeRel" ;;
		"Build Debug") echo "Build Debug" ;;
		"Build Release") echo "Build Release" ;;
		"Build RelWithDebInfo") echo "Build RelWithDebInfo" ;;
		"Build MinSizeRel") echo "Build MinSizeRel" ;;
		"Clang Build Debug") echo "Clang Build Debug" ;;
		"Clang Build Release") echo "Clang Build Release" ;;
		"Clang Build RelWithDebInfo") echo "Clang Build RelWithDebInfo" ;;
		"Clang Build MinSizeRel") echo "Clang Build MinSizeRel" ;;
		"GNU Build Debug") echo "GNU Build Debug" ;;
		"GNU Build Release") echo "GNU Build Release" ;;
		"GNU Build RelWithDebInfo") echo "GNU Build RelWithDebInfo" ;;
		"GNU Build MinSizeRel") echo "GNU Build MinSizeRel" ;;

		*)
			echo "Unknown"
			;;
	esac
}
