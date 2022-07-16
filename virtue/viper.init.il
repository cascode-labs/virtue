/*****************************************************************
 *                                                               *
 *                    Virtuoso initialization                    *
 *                                                               *
 *  Initializes the current conda environment's SKILL library    *
 *  located at $PREFIX/lib/skill                                 *
 *                                                               *
 *****************************************************************/

printf("Initializing Conda SKILL environment\n")

let((prefix file_path prefix_skill suffix_order files)

	; Loadi all the files from a directory with the file suffix
	;  suffix defaults to skill, "*.il", files
	procedure(ConLoadiDir(dir @optional (suffix ".il"))
		let((files suffixLength)
		suffixLength = strlen(suffix)
		files = getDirFiles(dir)
		; Avoids loading this file again recursively
		files = remove("conda-virtuoso.init.il" files)
		when(files
			foreach(file files
				when((substring(file -suffixLength suffixLength) == suffix)
					loadi(strcat(dir "/" file)))))
	))

	; Loadi all the files from dir and all subdirs in it
    ; with the file suffix. It only goes 1 level deep
	;  suffix defaults to skill, "*.il", files
	procedure(ConLoadiSubDir(dir @optional (suffix ".il"))
		let((files)
		ConLoadiDir(dir suffix)
		files = getDirFiles(prefix_skill)
		when(files
			foreach(file files
				when(isDir(strcat(strcat(dir "/" file)))
					;printf("  Loading projects from %s: \n" prefix_skill)
					ConLoadiDir(strcat(dir "/" file) suffix))))
	))

	; Check Paths
	if(getShellEnvVar("CONDA_PREFIX") && 
	   isDir(getShellEnvVar("CONDA_PREFIX")) then
		prefix = getShellEnvVar("CONDA_PREFIX")
		prefix_skill = strcat(prefix "/lib/skill")
	else
		warn(strcat(
			"  $CONDA_PREFIX is not defined\n"
			"   conda-virtuoso should be initialized in a conda environment.\n")
			"   Check that your conda environment was activated")
		; Load the SKILL libraries in the same directory as this file
		file_path = simplifyFilename(get_filename(piport))
		prefix_skill = buildString(reverse(cdr(
							reverse(parseString(file_path "/")))) "/")
	)
	
	printf(" conda environment prefix:\n")
	printf("  %s\n" getShellEnvVar("CONDA_PREFIX"))	
	printf(" Conda environment SKILL library root:\n")
	printf("  %s\n" prefix_skill)
	
	; Report each of the skill packages (dirs) to be initialized
	printf(" Initializing Packages:\n")
	files = getDirFiles(prefix_skill)
	when(files
		foreach(file files
			when(isDir(strcat(strcat(prefix_skill "/" file)))
				printf(strcat("  * " file "\n")))))
	
	; Load init files directly from conda env skill lib in this order
	suffix_order = list(
	; first
	"preinit.il"
	"preinit.ils"
	"init.il"
	"init.ils"
	"postinit.il"
	"postinit.ils"
	; last
	)
	foreach(suffix suffix_order
		ConLoadiSubDir(prefix_skill suffix))
)

printf("Done, initialized conda SKILL environment\n")
