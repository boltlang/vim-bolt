" Vim syntax file for Bolt, following tree-sitter-bolt's grammar.js.
"
" When a construct can't be told apart reliably with regexes, it is left
" unhighlighted rather than guessed at.

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn case match

" Operators and punctuation. These come first so that comments, which also
" start with '/', take priority when they start at the same position.
" Delimiters come before operators so that `..` wins over `.`.
syn match boltDelimiter "[,;:.]"
syn match boltDelimiter "[][(){}]"
syn match boltOperator "[-+*/%^!&|<>=?@]"
syn match boltOperator "\.\.[.=]\?"
syn match boltOperator "->\|=>"

" Keywords
syn keyword boltKeyword as async await const else extern fn impl in let
syn keyword boltKeyword mut pub import where
syn keyword boltConditional if match
syn keyword boltRepeat for while loop
syn keyword boltStatement return yield break continue
syn keyword boltBuiltin self super package
syn keyword boltBoolean true false
syn keyword boltType u8 i8 u16 i16 u32 i32 u64 i64 u128 i128 isize usize f32 f64
syn keyword boltType bool str char
syn match boltMacroRules "\<macro_rules!"

" `r#type` is an ordinary identifier, not the keyword `type`.
syn match boltRawIdentifier "\<r#\h\w*"

" Names introduced by declarations.
syn keyword boltKeyword struct enum class type nextgroup=boltTypeName skipwhite skipempty
syn match boltTypeName "\h\w*" contained
" `fn name(...)` and `fn name[T](...)`. Operator definitions like `fn a + b`
" have no name, so a following `(` or `[` is required.
syn match boltFunctionName "\%(\<fn\s\+\)\@<=\h\w*\ze\s*[[(]"

" Macros
syn match boltMacro "\<\h\w*!\ze\s*[([{]"
syn match boltMetavariable "\$\h\w*"

" Attributes: #[...] and #![...]
syn region boltAttribute matchgroup=boltAttribute start="#!\?\[" end="\]" contains=boltAttributeBrackets,boltString,boltRawString,boltChar,boltComment,boltBlockComment
syn region boltAttributeBrackets start="\[" end="\]" contained transparent contains=boltAttributeBrackets,boltString,boltRawString,boltChar,boltComment,boltBlockComment

" Shebang on the first line (but not an inner attribute `#![`)
syn match boltShebang "\%^#!\%(\s*\[\)\@!.*$"

" Numbers
syn match boltNumber "\<\d[0-9_]*\%(u8\|i8\|u16\|i16\|u32\|i32\|u64\|i64\|u128\|i128\|isize\|usize\|f32\|f64\)\?\>"
syn match boltNumber "\<0x[0-9a-fA-F_]\+\%(u8\|i8\|u16\|i16\|u32\|i32\|u64\|i64\|u128\|i128\|isize\|usize\)\?\>"
syn match boltNumber "\<0o[0-7_]\+\%(u8\|i8\|u16\|i16\|u32\|i32\|u64\|i64\|u128\|i128\|isize\|usize\)\?\>"
syn match boltNumber "\<0b[01_]\+\%(u8\|i8\|u16\|i16\|u32\|i32\|u64\|i64\|u128\|i128\|isize\|usize\)\?\>"
" Floats. Not after a '.', so tuple fields like `t.0.1` stay integers.
syn match boltFloat "\.\@1<!\<\d[0-9_]*\.\d[0-9_]*\%([eE][+-]\?[0-9_]*\d[0-9_]*\)\?\%(f32\|f64\)\?\>"
syn match boltFloat "\.\@1<!\<\d[0-9_]*\%(\.\d[0-9_]*\)\?[eE][+-]\?[0-9_]*\d[0-9_]*\%(f32\|f64\)\?\>"

" Labels and character literals. A char literal is defined last so it wins
" over a label starting at the same position.
syn match boltLabel "'\h\w*\>'\@!"
syn match boltChar "\<b\?'\%([^\\']\|\\\%(x\x\x\|u\x\{4}\|u{\x\+}\|[^xu]\)\)'"
syn match boltChar "'\%([^\\']\|\\\%(x\x\x\|u\x\{4}\|u{\x\+}\|[^xu]\)\)'"

" Strings
syn match boltEscape "\\\%(x\x\x\|u\x\{4}\|u{\x\+}\|[^xu]\)" contained
syn match boltEscape "\\$" contained
syn region boltString matchgroup=boltString start=+\<[bc]\?"+ start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=boltEscape
syn region boltRawString matchgroup=boltString start=+\<[bc]\?r\z(#*\)"+ end=+"\z1+

" Comments. Block comments nest.
syn keyword boltTodo contained TODO FIXME XXX NOTE
syn match boltComment "//.*$" contains=boltTodo
syn match boltDocComment "//\%(/\%([^/]\|$\)\|!\).*$" contains=boltTodo
syn match boltComment "////.*$" contains=boltTodo
syn region boltBlockComment start="/\*" end="\*/" contains=boltBlockComment,boltTodo
syn region boltDocBlockComment start="/\*\%(\*[*/]\@!\|!\)" end="\*/" contains=boltBlockComment,boltTodo

hi def link boltOperator Operator
hi def link boltDelimiter Delimiter
hi def link boltKeyword Keyword
hi def link boltConditional Conditional
hi def link boltRepeat Repeat
hi def link boltStatement Statement
hi def link boltBuiltin Special
hi def link boltBoolean Boolean
hi def link boltType Type
hi def link boltMacroRules Macro
hi def link boltTypeName Type
hi def link boltFunctionName Function
hi def link boltMacro Macro
hi def link boltMetavariable Identifier
hi def link boltAttribute PreProc
hi def link boltShebang Comment
hi def link boltNumber Number
hi def link boltFloat Float
hi def link boltLabel Label
hi def link boltChar Character
hi def link boltEscape SpecialChar
hi def link boltString String
hi def link boltRawString String
hi def link boltTodo Todo
hi def link boltComment Comment
hi def link boltBlockComment Comment
hi def link boltDocComment SpecialComment
hi def link boltDocBlockComment SpecialComment

let b:current_syntax = "bolt"

let &cpo = s:cpo_save
unlet s:cpo_save
