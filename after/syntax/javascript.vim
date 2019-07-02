" File:         javascript.vim
" Last Change:  07/01/2019
" Maintainer:   FrancescoMagliocco

syn keyword jsProp constructor prototype length E LN2 LN10 LOG2E LOG10E PI
syn keyword jsProp SQRT1_2 SQRT2 MAX_VALUE MIN_VALUE NEGATIVE_INFINITY
syn keyword jsProp POSITIVE_INFINITY

" Date Object Methods
syn keyword jsBuiltInMethods getDate getDay getFullYear getHours 
syn keyword jsBuiltInMethods getMilliseconds getMinutes getMonth getSeconds 
syn keyword jsBuiltInMethods getTime getTimezoneOffset getUTCDate getUTCDay 
syn keyword jsBuiltInMethods getUTCFullYear getUTCHours getUTCMilliseconds 
syn keyword jsBuiltInMethods getUTCMinutes getUTCMonth getUTCSeconds now parse 
syn keyword jsBuiltInMethods setDate setFullYear setHours setMilliseconds 
syn keyword jsBuiltInMethods setMinutes setMonth setSeconds setTime setUTCDate 
syn keyword jsBuiltInMethods setUTCFullYear setUTCHours setUTCMilliseconds 
syn keyword jsBuiltInMethods setUTCMinutes setUTCSeconds toDateString 
syn keyword jsBuiltInMethods toISOString toJSON toLocaleDateString 
syn keyword jsBuiltInMethods toLocaleTimeString toLocaleString toString 
syn keyword jsBuiltInMethods toTimeString toUTCString UTC valueOf concat
syn keyword jsBuiltInMethods copyWithin entries every fill filter find
syn keyword jsBuiltInMethods findIndex forEach from includes indexOf isArray
syn keyword jsBuiltInMethods join keys lastIndexOf map pop push reduce
syn keyword jsBuiltInMethods reduceRight reverse shift slice some sort splice
syn keyword jsBuiltInMethods stringify unshift isSafeInteger toExponential
syn keyword jsBuiltInMethods toFixed toPrecision

syn keyword jsBuiltInMethods abs acos acosh asin asinh atan atan2 atanh cbrt
syn keyword jsBuiltInMethods ceil cos cosh exp floor log max min pow random
syn keyword jsBuiltInMethods round sin sinh sqrt tan tanh trunc

" Global Properties
syn keyword jsGlobalProp  Infinity NaN unndefined

" Global Object Functions
syn keyword jsGlobalFunc decodeURI decodeURIComponent encodeURI
syn keyword jsGlobalFunc encodeURIComponent eval isFinite isNaN Number
syn keyword jsGlobalFunc parseFloat parseInt String

" Error Object properties
syn keyword jsErrorProp  name message

syn keyword jsDeprecated  getYear setYear toGMTString escape unescape

hi def link jsProp property
hi def link jsBuiltInMethods method
hi def link jsGlobalProp property
hi def link jsGlobalFunc functionName
hi def link jsErrorProp property
