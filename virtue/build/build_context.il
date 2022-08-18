procedure(BuildContext(context_name init_filepath @key save_dir_path  context_init_procedure "ttts")
  "Build a context for the code initialized by init_filepath.
   @param context_name The name of the context
   @param init_filepath Path to a SKILL script file which loads all the code to include in the context.
   @param save_dir_path The directory where the context will be saved.
     The filename will match the given name of the context.
   @param context_init_procedure The symbol of the context
     initialization procedure which will run when the context is loaded."
  let((file_path
       (old_status status(writeProtect))
      )
  if(save_dir_path then
    file_path = strcat(save_dir_path "/" context_name ".cxt")
  else
    file_path = strcat(context_name ".cxt"))
  sstatus(writeProtect t)

  setContext(context_name)
  load(init_filepath)
  when(context_init_procedure
    defInitProc(context_init_procedure))
  saveContext(file_path)

  unless(old_status
    sstatus(writeProtect nil))
  callInitProc(context_name)
))

BuildContext("virtue" "../virtue/virtue.init.ils")
