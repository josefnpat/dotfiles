" Vim global plugin that provides access to the codepad.org pastebin.
" Requires +python support.
"
" Add this to your ~/.vim/plugin/ directory. Then you can use
"
" :CPPaste or :'<,'>CPPaste
"     to send the current buffer or range to codepad.org and put the link in
"     your clipboard.
"
" :CPRun or :'<,'>CPRun
"     to send the current buffer or range to codepad.org, execute it on their
"     server, and put the link in your clipboard.
"
" The correct filetype is automatically detected from the 'filetype' variable.
" set `webbrowser_enabled = True` if you would like the file to open in the
" default web browser.
"
" Version: 1.5
" Last Change: 2016 Feb 23
" Maintainer: Josef Patoprsty <seppi at josefnpat.com>
" Original Maintainer:   Nicolas Weber <nicolasweber at gmx.de>

if has('python')
  command! -range CPPaste python codepadPaste()
  command! -range CPRun python codepadRun()
else
  command! -range CPPaste echo 'Only avaliable with +python support.'
  command! -range CPRun echo 'Only avaliable with +python support.'
endif

if has('python')
python << EOF

webbrowser_enabled = False

def codepadLang(vimLang):
  filetypeMap = {
    'c':'C',
    'cpp':'C++',
    'd':'D',
    'haskell':'Haskell',
    'lua':'Lua',
    'ocaml':'OCaml',
    'php':'PHP',
    'perl':'Perl',
    'python':'Python',
    'ruby':'Ruby',
    'scheme':'Scheme',
    'tcl':'Tcl'
  }
  return filetypeMap.get(vimLang, 'Plain Text')


def codepadGet(run,lines):
  import urllib
  import vim

  url = 'http://codepad.org'
  data = {
    'code':"\n".join(lines),
    'lang':codepadLang(vim.eval('&filetype')),
    'submit':'Submit'
  }
  if run:
    data['run'] = True

  response = urllib.urlopen(url, urllib.urlencode(data))
  return response.geturl()

def codepadGetLines():
  import vim

  if vim.current.buffer.mark('<') is None:
    lines = vim.current.buffer
  else:
    (lnum1, col1) = vim.current.buffer.mark('<')
    vim.command("delmarks <")
    (lnum2, col2) = vim.current.buffer.mark('>')
    vim.command("delmarks >")
    lines = vim.eval('getline({}, {})'.format(lnum1, lnum2))
    if len(lines) == 1:
      lines[0] = lines[0][col1:col2 + 1]
    else:
      lines[0] = lines[0][col1:]
      lines[-1] = lines[-1][:col2 + 1]

  return lines

def codepadPaste():
  cleanup(codepadGet(run=False,lines=codepadGetLines()))

def codepadRun():
  cleanup(codepadGet(run=True,lines=codepadGetLines()))

def cleanup(url):
  import vim
  vim.command("call setreg('+', '%s')" % url)
  vim.command("call setreg('*', '%s')" % url)
  print url
  if webbrowser_enabled:
    import webbrowser
    webbrowser.open(url)

EOF
endif
