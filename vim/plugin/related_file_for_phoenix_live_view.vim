" Lets you use the :R command to jump between e.g. foo_live.ex and foo_live.html.leex in Phoenix LiveView.
" Inspired by corresponding functionality in vim-rails.

function! s:RelatedFileForPhoenixLiveView()
  let l:path = expand("%")
  if l:path =~ "/live/.*\\.ex$"
    let l:rel = substitute(l:path, "\\.ex$", ".html.leex", "")
  elseif l:path =~ "\\.html\\.leex$"
    let l:rel = substitute(l:path, "\\.html\\.leex$", ".ex", "")
  else
    return
  end

  if filereadable(l:rel)
    execute "edit" l:rel
  else
    echoerr "No such related file: " l:rel
  endif
endfunction

augroup related_file_for_phoenix_live_view
  autocmd!
  autocmd BufNewFile,BufRead */live/*.ex,*.html.leex command! -buffer R call <SID>RelatedFileForPhoenixLiveView()
augroup END
