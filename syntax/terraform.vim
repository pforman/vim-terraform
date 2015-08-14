" Forked from Larry Gilbert's syntax file
" github.com/L2G/vim-syntax-terraform

if exists("b:current_syntax")
  finish
endif

syn case match

syn keyword terraSection connection output provider variable
syn keyword terraValueBool true false on off yes no

""" old resource keyword section
" find . -name "resource_*.go" -not -name "resource_*_test.go" -not -name "resource_provider.go" | sed 's/.*\/resource_//; s/\.go$//'
""" This is impossible to maintain, Terraform has 70 *aws* resources now.
""" Just stop trying.  Remove later.
" syn keyword terraResourceTypeBI

syn keyword terraTodo         contained TODO FIXME XXX BUG
syn cluster terraCommentGroup contains=terraTodo
syn region  terraComment      start="/\*" end="\*/" contains=@terraCommentGroup,@Spell
syn region  terraComment      start="#" end="$" contains=@terraCommentGroup,@Spell
syn region  terraComment      start="//" end="$" contains=@terraCommentGroup,@Spell

""" resource
syn match  terraResource        /\<resource\>/ nextgroup=terraResourceType skipwhite
syn region terraResourceType    start=/"/ end=/"/
                              \ nextgroup=terraResourceName skipwhite
syn region terraResourceName    start=/"/ end=/"/
                              \ nextgroup=terraResourceBlock skipwhite
""" provider
syn match  terraProvider      /\<provider\>/ nextgroup=terraProviderName skipwhite
syn region terraProviderName  start=/"/ end=/"/ nextgroup=terraProviderBlock skipwhite

""" provisioner
syn match  terraProvisioner     /\<provisioner\>/ nextgroup=terraProvisionerName skipwhite
syn region terraProvisionerName start=/"/ end=/"/ nextgroup=terraProvisionerBlock skipwhite

""" module
syn match  terraModule     /\<module\>/ nextgroup=terraModuleName skipwhite
syn region terraModuleName start=/"/ end=/"/ nextgroup=terraModuleBlock skipwhite

""" misc.
syn match terraValueDec      "\<[0-9]\+\([kKmMgG]b\?\)\?\>"
syn match terraValueHexaDec  "\<0x[0-9a-f]\+\([kKmMgG]b\?\)\?\>"
syn match terraBraces        "[{}\[\]]"

""" skip \" in strings.
""" we may also want to pass \\" into a function to escape quotes.
syn region terraValueString   start=/"/ skip=/\\\+"/ end=/"/ contains=terraStringInterp
syn region terraStringInterp  matchgroup=terraBrackets start=/\${/ end=/}/ contains=terraValueFunction contained
"" TODO match keywords here, not a-z+
syn region terraValueFunction matchgroup=terraBrackets start=/[a-z]\+(/ end=/)/ contains=terraValueString,terraValueFunction contained

hi def link terraComment           Comment
hi def link terraTodo              Todo
hi def link terraBrackets          Operator
hi def link terraProvider          Structure
hi def link terraBraces            Delimiter
hi def link terraProviderName      String
hi def link terraResource          Structure
hi def link terraResourceName      String
hi def link terraResourceType      Tag
hi def link terraSection           Structure
hi def link terraStringInterp      Identifier
hi def link terraValueBool         Boolean
hi def link terraValueDec          Number
hi def link terraValueHexaDec      Number
hi def link terraValueString       String
hi def link terraProvisioner       Structure
hi def link terraProvisionerName   String
hi def link terraModule            Structure
hi def link terraModuleName        String
hi def link terraValueFunction     Identifier

let b:current_syntax = "terraform"
