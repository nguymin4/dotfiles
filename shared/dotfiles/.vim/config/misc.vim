function ProfilingPerf(log_name)
  echo 'Start profiling ' . fnamemodify(a:log_name, ':p')
  execute 'profile start' a:log_name
  profile file *
  profile func *
endfunction
