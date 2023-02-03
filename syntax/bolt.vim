
if exists("b:current_syntax")
  finish
endif

syn keyword boltKeyword struct enum pub mut let for if else elif in match impl class type import as mod foreign handle effect
syn keyword boltFunction return perform yield resume
syn match boltOperator "[-+*/^&%$!?<>=|]\+"
syn region boltString start=/\v"/ end=/\v"/ contains=boltEscapeSequence
syn region boltString start=/\v'/ end=/\v'/ contains=boltEscapeSequence
syn match boltEscapeSequence "\\[abfnrtv0\\]"
syn region boltComment start='#' end='\n'
syn match boltInteger "[0-9]\+"
syn match boltDelimiter "[\.\]\[)(}{,]"

highlight link boltString String
highlight link boltKeyword Keyword
highlight link boltComment Comment
highlight link boltNumber Number
highlight link boltDelimiter Delimiter
highlight link boltFunction Function
highlight link boltOperator Operator
highlight link boltEscapeSequence Special

