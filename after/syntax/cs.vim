" File:         cs.vim
" Last Change:  06/12/2019
" Maintainer:   FrancescoMagliocco

function! s:test()
  if len(filter(getline(1, line('$')), "v:val =~# '^\\s*using\\s\\+System;'"))
    syn keyword csBuiltInClasses  AccessViolationException ActivationContext
    syn keyword csBuiltInClasses  Activator AggregateException AppContext
    syn keyword csBuiltInClasses  AppDomain AppDomainManager AppDomainSetup
    syn keyword csBuiltInClasses  AppDomainUnloadedException ApplicationException
    syn keyword csBuiltInClasses  ApplicationId ApplicationIdentity
    syn keyword csBuiltInClasses  ApplicationException ApplicationNullException
    syn keyword csBuiltInClasses  ArgumentOutOfRangeException ArithmeticException
    syn keyword csBuiltInClasses  Array ArrayTypeMismatchException
    syn keyword csBuiltInClasses  AssemblyLoadEventArgs Attribute
    syn keyword csBuiltInClasses  AttributeUsageAttribute BadImageFormatException
    syn keyword csBuiltInClasses  BitConverter Buffer
    syn keyword csBuiltInClasses  CannotUnloadAppDomainException CharEnumerator
    syn keyword csBuiltInClasses  CLSCompliantAttribute Console
    syn keyword csBuiltInClasses  ConsoleCancelEventArgs ContextBoundObject
    syn keyword csBuiltInClasses  ContextStaticAttribute
    syn keyword csBuiltInClasses  Convert DataMisalignedException DBNull Delegate
    syn keyword csBuiltInClasses  DivideByZeroException DllNotFoundException
    syn keyword csBuiltInClasses  DuplicateWaitObjectException
    syn keyword csBuiltInClasses  EntryPointNotFoundException Enum Environment
    syn keyword csBuiltInClasses  EventArgs Exception
    syn keyword csBuiltInClasses  FieldAccessException FileStyleUriParser
    syn keyword csBuiltInClasses  FlagsAttribute FormatException FormattableString
    syn keyword csBuiltInClasses  FtpStyleUriParser GC GenericUriParser
    syn keyword csBuiltInClasses  GopherStyleUriParser HttpStyleUriParser
    syn keyword csBuiltInClasses  IndexOutOfRangeException
    syn keyword csBuiltInClasses  InsufficientExecutionStackAcception
    syn keyword csBuiltInClasses  InsufficientMemoryException InvalidCastException
    syn keyword csBuiltInClasses  InvalidOperationException
    syn keyword csBuiltInClasses  InvalidProgramException InvalidTimeZoneException
    syn keyword csBuiltInClasses  Lazy LdapStyleUriParser
    syn keyword csBuiltInClasses  LoaderOptimizationAttribute LocalDataStoreSlot
    syn keyword csBuiltInClasses  MarshalByRefObject Math MemberAcessException
    syn keyword csBuiltInClasses  MethodAccessException MissingFieldException
    syn keyword csBuiltInClasses  MissingMemberException MTAThreadAttribute
    syn keyword csBuiltInClasses  MulticastDelegate MulticastNotSupportException
    syn keyword csBuiltInClasses  NetPipeStyleUriParser NetTcpStyleUriParser
    syn keyword csBuiltInClasses  NewsStyleUriParser NonSerializedAttribute
    syn keyword csBuiltInClasses  NotFiniteNumberException NotImplementedException
    syn keyword csBuiltInClasses  NotSupportedException Nullable
    syn keyword csBuiltInClasses  NullReferenceException Object
    syn keyword csBuiltInClasses  ObjectDisposedException ObsoleteAttribute
    syn keyword csBuiltInClasses  OperatingSystem OperationCanceledException
    syn keyword csBuiltInClasses  OutOfMemoryException OverflowException
    syn keyword csBuiltInClasses  ParamArrayAttribute
    syn keyword csBuiltInClasses  PlatformNotSupportedException Progress Random
    syn keyword csBuiltInClasses  RankException ResolveEventArgsArgs
    syn keyword csBuiltInClasses  SerializableAttribute StackOverflowException
    syn keyword csBuiltInClasses  STAThreadAttribute String StringComparer
    syn keyword csBuiltInClasses  StringNormalizationExtensions SystemException
    syn keyword csBuiltInClasses  ThreadStaticAttribute TimeoutException
    " COMBAK
    syn keyword csBuiltInClasses  TimeZoneInfo TimeZoneInfo.AdjustmentRule
    syn keyword csBuiltInClasses  TimeZoneNotFoundException Tuple TupleExtensions
    syn keyword csBuiltInClasses  Type TypeAcessException
    syn keyword csBuiltInClasses  TypeInitialzationException TypeLoadException
    syn keyword csBuiltInClasses  TypeUnloadedException
    syn keyword csBuiltInClasses  UnauthorizedAccessException
    syn keyword csBuiltInClasses  UnhandledExceptionPoint Uri UriBuilder
    syn keyword csBuiltInClasses  UriFormatException UriParser UriTemplate
    syn keyword csBuiltInClasses  UriTemplateEquivalenceComparer
    syn keyword csBuiltInClasses  UriTemplateMatch UriTemplateMatchException
    syn keyword csBuiltInClasses  UriTemplateTable UriTypeConverter ValueType
    syn keyword csBuiltInClasses  Version WeakReference
    syn keyword csBuiltInStructs  ArgIterator ArraySegment Boolean Byte Char
    syn keyword csBuiltInStructs  ConsoleKeyInfo DateTime DateTimeOffset Decimal
    syn keyword csBuiltInStructs  Double Guid Int16 Int32 Int64 IntPtr
    syn keyword csBuiltInStructs  ModuleHandle Nullable RuntimeArgumentHandle
    syn keyword csBuiltInStructs  RuntimeFieldHandle RuntimeMethodHandle
    syn keyword csBuiltInStructs  RuntimeTypeHandle SByte Single TimeSpand
    " COMBAK
    syn keyword csBuiltInStructs  TimeZoneInfoTransitionTime
    syn keyword csBuiltInStructs  TypedReference UInt16 UInt32 Uint64 UIntPtr
    syn keyword csBuiltInStructs  ValueTuple Void
    syn keyword csBuiltInInterfaces _AppDomain IAppDomainSetup IAsyncResult
    syn keyword csBuiltInInterfaces ICloneable IComparable IConvertible
    syn keyword csBuiltInInterfaces ICustomFormatter IDisposable IEquatable
    syn keyword csBuiltInInterfaces IFormatProvider IFormattable IObservable
    syn keyword csBuiltInInterfaces IProgress IServiceProvider
    " COMBAK
    syn keyword csBuiltInEnums  ActivationContext.ContextForm
    syn keyword csBuiltInEnums  AppDomainManagerInitializationOptions
    syn keyword csBuiltInEnums  AttributeTargets Base64FormattingOptions
    syn keyword csBuiltInEnums  ConsoleColor ConsoleKey ConsoleModifiers
    syn keyword csBuiltInEnums  ConsoleSpecialKey DateTimeKind DayOfWeek
    " COMBAK
    syn keyword csBuiltInEnums  Envrionment.SpecialFolder Environment.SpecialFolderOption
    syn keyword csBuiltInEnums  EnvironmentVariableTarget GCCollectionMode
    syn keyword csBuiltInEnums  GCNotificationStatus GenericParserOptions
    syn keyword csBuiltInEnums  LoaderOptimization MidpointRounding PlatformID
    syn keyword csBuiltInEnums  StringComparison StringSplitOptions TypeCode
    syn keyword csBuiltInEnums  UriComponents UriFormat UriHostNameType UriKind
    syn keyword csBuiltInEnums  UriPartial
    syn keyword csBuiltInDelegates  Action AppDomainInitializer
    syn keyword csBuiltInDelegates  AssemblyLoadEventHandler AsyncCallback
    syn keyword csBuiltInDelegates  Comparison ConsoleCancelEventHandler Converter
    syn keyword csBuiltInDelegates  CrossAppDomainDelegate EventHandler Func
    syn keyword csBuiltInDelegates  Predicate ResolveEventHandler
    syn keyword csBuiltInDelegates  UnhandledExceptionEventHandler
    " Inherited from Object
    syn keyword csBuiltInMethods Equals Finalize GetHashCode GetType
    syn keyword csBuiltInMethods MemberwiseClone ReferenceEquals ToString
    " Inherited from Exception
    syn keyword csBuiltInEvents   SerializeObjectState
    syn keyword csBuiltInMethods  GetBaseException GetObjectData
    "syn keyword csBuiltInProp       Data HelpLink HResult InnerException Message
    "syn keyword csBuiltInProp       Source StackTrace TargetSite
    " Inherited from MarshalByRefObject
    syn keyword csBuiltInMethods  CreateObjectRef GetLifetimeService
    syn keyword csBuiltInMethods  InitializeLifetimeService
    " Inherited from TypeLocalException
    syn keyword csBuiltInMethods  GetObjectData
    "syn keyword csBuiltInProp     Message TypeName
    " Inherited from UriParser
    syn keyword csBuiltInMethods  GetComponents InitializeAndValidate IsBaseOf
    syn keyword csBuiltInMethods  IsKnownScheme IsWellFormedOriginalString
    syn keyword csBuiltInMethods  OnNewUri OnRegister Register Resolve
    " Activation Context
    syn keyword csBuiltInMethods  CreatePartialActivationContext Dispose Finalize
    "syn keyword csBuiltInProp     ApplicationManifestBytes DeploymentManifestBytes
    "syn keyword csBuiltInProp     Form Identity
    " Activator
    syn keyword csBuiltInMethods  CreateComInstanceFrom CreateInstance
    syn keyword csBuiltInMethods  CreateInstanceFrom GetObject
    " AggregateException
    syn keyword csBuiltInMethods  Flatten GetBaseException Handle ToString
    "syn keyword csBuiltInProp     InnerExceptions
    " AppContext
    syn keyword csBuiltInMethods  GetData SetSwitch TryGetSwitch
    "syn keyword csBuiltInProp     BaseDirectory TargetFrameworkName
    " AppDomain
    "syn keyword csBuiltInProp     ActivationContext ApplicationIdentity
    "syn keyword csBuiltInProp     ActivationTrust BaseDirectory CurrentDomain
    "syn keyword csBuiltInProp     DomainManager DynamicDirectory Evidence
    "syn keyword csBuiltInProp     FriendlyName Id IsFullyTrusted IsHomogenous
    "syn keyword csBuiltInProp     MonitoringIsEnabled MonitoringSurvivedMemorySize
    "syn keyword csBuiltInProp     MonitoringSurvivedProcessMemorySize
    "syn keyword csBuiltInProp     MonitoringTotalAllocatedMemorySize
    "syn keyword csBuiltInProp     MonitoringTotalProcessorTime PermissionSet
    "syn keyword csBuiltInProp     RelativeSearchPath SetupInformation
    syn keyword csBuiltInMethods  AppendPrivate ApplyPolicy CreatePribatePath
    syn keyword csBuiltInMethods  ClearShadowCopy CreateComInstanceFrom
    syn keyword csBuiltInMethods  CreateDomain CreateInstance
    syn keyword csBuiltInMethods  CreateInstanceAndUnwrap CreateInstanceFrom
    syn keyword csBuiltInMethods  CreateInstanceFromAndUnwrap CreateObjRef
    syn keyword csBuiltInMethods  DefineDynamicAssembly DoCallBack ExecuteAssembly
    syn keyword csBuiltInMethods  ExecuteAssemblyByName GetAssemblies
    syn keyword csBuiltInMethods  GetCurentThreadId GetData GetType
    syn keyword csBuiltInMethods  InitializeLifetimeService
    syn keyword csBuiltInMethods  IsCompatibilitySwitchSet IsDefaultAppDomain
    syn keyword csBuiltInMethods  IsFinalizingForUnload Load
    syn keyword csBuiltInMethods  ReflectionOnlyGetAssemblies SetAppDomainPolicy
    syn keyword csBuiltInMethods  SetCachePath SetData SetDynamicBase
    syn keyword csBuiltInMethods  SetPrinicplePolicy SetShadowCopy
    syn keyword csBuiltInMethods  SetShadowCopyPath SetThreadPrinciple ToString
    syn keyword csBuiltInMethods  Unload
    syn keyword csBuiltInEvents   AssemblyLoad AssemblyResolve DomainUnloaded
    syn keyword csBuiltInEvents   FirstChanceException ProcessExit ReflectionOnly
    syn keyword csBuiltInEvents   ResourceResolve TypeResolve Unhandled
    syn keyword csBuiltInEvents   UnhandledException
    " AppDomainManager
    "syn keyword csBuiltInProp     ApplicationActivator EntryAssembly
    "syn keyword csBuiltInProp     HostExecutionContextManager HostSecurityManager
    "syn keyword csBuiltInProp     InitializingFlags
    syn keyword csBuiltInMethods  CheckSecuritySettings CreateDomain
    syn keyword csBuiltInMethods  CreateDomainHelper InitializeNewDomain
    " AppDomainSetup
    syn keyword csBuiltInMethods  GetConfigurationBytes SetCompatibilitySwitches
    syn keyword csBuiltInMethods  SetConfigurationBytes SetNativeFunction
    "syn keyword csBuiltInProp     ActivationArguments AppDomainInitializer
    "syn keyword csBuiltInProp     AppDomainInitializerArguments
    "syn keyword csBuiltInProp     AppDomainMangerAssembly AppDomainMangerType
    "syn keyword csBuiltInProp     ApplicationBase ApplicationName ApplicatoinTrust
    "syn keyword csBuiltInProp     CachePath ConfigurationFile
    "syn keyword csBuiltInProp     DisallowApplicationBaseProbing
    "syn keyword csBuiltInProp     DisallowBindingRedirects DisallowCodeDownload
    "syn keyword csBuiltInProp     DisallowPublicPolicy DynamicBase LicenseFile
    "syn keyword csBuiltInProp     LoaderOptimization PartialTrustVisibleAssemblies
    "syn keyword csBuiltInProp     PrivateBinPath PrivateBinPathProbe
    "syn keyword csBuiltInProp     SandboxInterop ShadowCopyDirectories
    "syn keyword csBuiltInProp     ShadowCopyFiles TargetFrameworkName
    " ApplicationId
    syn keyword csBuiltInMethods  Copy Equals GetHashCode ToString
    "syn keyword csBuiltInProp     Culture Name ProcessorArchitecture
    "syn keyword csBuiltInProp     PublicKeyToken Version
    " ApplicationIdentity
    syn keyword csBuiltInMethods  ToString
    "syn keyword csBuiltInProp     CodeBase FullName
    " ArgumentException
    syn keyword csBuiltInMethods  GetObjectData
    "syn keyword csBuiltInProp     Message ParamName
    " ArgumentOutOfRanceException
    "syn keyword csBuiltInProp     ActualValue Message
    " Array
    syn keyword csBuiltInMethods  AsReadOnly BinarySearch Clear ConstrainedCopy
    syn keyword csBuiltInMethods  ConvertAll Copy CopyTo CreateInstance Empty
    syn keyword csBuiltInMethods  Exists Find FindAll FindIndex FindLastIndex
    syn keyword csBuiltInMethods  ForEach GetEnumerator GetLength GetLongLength
    syn keyword csBuiltInMethods  GetLowerBound GetUpperBound GetValue IndexOf
    syn keyword csBuiltInMethods  Initialize LastIndexOf Resize Reverse SetValue
    syn keyword csBuiltInMethods  Sort TrueForAll
    "syn keyword csBuiltInPro      IsFixedSize IsReadOnly IsSyncronized Length
    "syn keyword csBuiltInPro      LongLength Rank SyncRoot
    " AssemblyLoadEventArgs
    "syn keyword csBuiltInProp     LoadedAssembly
    " Attribute
    syn keyword csBuiltInMethods  Equals GetCustomAttrbute GetCustomAttributes
    syn keyword csBuiltInMethods  GetHashCode IsDefaultAttribute IsDefined
    "syn keyword csBuiltInProp     TypeId
    " AttrivuteUsageAttribute
    "syn keyword csBuiltInProp     AllowMultiple Inherited ValidOn
    " BadImageFormatException
    syn keyword csBuiltInMethods  ToString
    "syn keyword csBuiltInProp     FileName FustionLog Message
    " BitConverter
    syn keyword csBuiltInFields   IsLittleEndian
    syn keyword csBUiltInMethods  DoubleToInt64Bits GetBytes Int64BitsToDouble
    syn keyword csBUiltInMethods  ToBoolean ToChar ToDouble ToInt16 ToInt32
    syn keyword csBUiltInMethods  ToInt64 ToSingle ToString ToUInt16 ToUInt32
    syn keyword csBUiltInMethods  ToUInt64
    " Buffer
    syn keyword csBuiltInMethods  BlockCopy ByteLength GetByte MemoryCopy SetByte
    " CharEnumerator
    syn keyword csBuiltInMethods  Clone Dispose MoveNext Reset
    "syn keyword csBuiltInProp     Current
    " CLSCompliantAttribute
    "syn keyword csBuiltInProp     IsCompliant
    " Console
    syn keyword csBuiltInEvents   CancelKeyPress
    syn keyword csBuiltInMethods  Beep Clear MoveBufferArea OpenStandardError
    syn keyword csBuiltInMethods  OpenStandardInput OpenStandardOutput Read
    syn keyword csBuiltInMethods  ReadKey ReadLine Reset SetBufferSize
    syn keyword csBuiltInMethods  SetCursorPosition SetError SetIn SetOut
    syn keyword csBuiltInMethods  SetWindowPosition SetWindowSize Write WriteLine
    "syn keyword csBuiltInProp     BackgroundColor BufferHeight BufferWidth
    "syn keyword csBuiltInProp     CapsLock CursorLeft CursorSize CursorTop
    "syn keyword csBuiltInProp     CurosrVisible Error ForegroundColor In
    "syn keyword csBuiltInProp     InputEncoding IsErrorRedirected
    "syn keyword csBuiltInProp     IsInputRedirected IsOutputRedirected
    "syn keyword csBuiltInProp     KeyAvailable LargestWindowHeight
    "syn keyword csBuiltInProp     LargestWinndowWidth NumberLock Out
    "syn keyword csBuiltInProp     OutputEncoding Title TreatControlCAsInput
    "syn keyword csBuiltInProp     WindowHeight WindowLeft WindowTop WindowWidth
    " ConsoleCancelEvantArgs
    "syn keyword csBuiltInProp     Cancel SpecialKey
    " Convert
    syn keyword csBuiltInFields   DBNull
    syn keyword csBuiltInMethods  ChangeType FromBase64CharArray
    syn keyword csBuiltInMethods  FromBase64CharString GetTypeCode IsDBNull
    syn keyword csBuiltInMethods  ToBase64CharArray ToBase64CharString ToBoolean
    syn keyword csBuiltInMethods  ToByte ToChar ToDateTime ToDecimal ToDouble
    syn keyword csBuiltInMethods  ToInt16 ToInt32 ToInt64 ToSByte ToSingle
    syn keyword csBuiltInMethods  ToString ToUInt16 ToUInt32 ToUInt64
    " DBNull
    syn keyword csBuiltInFields   Value
    syn keyword csBuiltInMethods  GetObjectData GetTypeCode ToString
    " Delegate
    syn keyword csBulitInExtMethods GetMethodInfo
    syn keyword csBuiltInMethods  Clone Combine CreateDelegate DynamicInvoke
    syn keyword csBuiltInMethods  DynamicInvokeImpl Equals GetHashCode
    syn keyword csBuiltInMethods  GetInvocationList GetMethodImpl GetObjectData
    syn keyword csBuiltInMethods  Remove RemoveAll RemoveImpl
    syn keyword csBuiltInOperators  Equality Inequality
    "syn keyword csBuiltInProp     Method Target
    syn keyword csBuiltInMethods  CompareTo Equals Format GetHashCode GetName
    syn keyword csBuiltInMethods  GetNames GetTypeCode GetUnderlyingType GetValues
    syn keyword csBuiltInMethods  HasFlag IsDefined Parse ToObject ToString
    syn keyword csBuiltInMethods  TryParse
    " Environment
    syn keyword csBuiltInMethods  Exit ExpandEnvironmentVariables FailFast
    syn keyword csBuiltInMethods  GetCommandLine GetEnvironmenntVariable
    syn keyword csBuiltInMethods  GetEnvironmentVariables GetFolderPath
    syn keyword csBuiltInMethods  GetLogicalDrives SetEnvironmentVariable
    "syn keyword csBuiltInProp     CommandLine  CurrentDirectory
    "syn keyword csBuiltInProp     CurrentManagedThreadId ExitCode
    "syn keyword csBuiltInProp     HasShutdownStarted Is64BitOperatingSystem
    "syn keyword csBuiltInProp     Is64BitProcess MachineName NewLine OSVersion
    "syn keyword csBuiltInProp     ProcessorCound StackTrace SystemDirectory
    "syn keyword csBuiltInProp     SystemPageSize TickCount UserDomainName
    "syn keyword csBuiltInProp     UserInteractive UserName Version WorkingSet
    " EventArgs
    syn keyword csBuiltInFields   Empty
    " FormattableString
    syn keyword csBuiltInMethods  GetArgument GetArguments Invariant ToString
    "syn keyword csBuiltInProp     ArgumentCound Format
    " GC
    syn keyword csBuiltInMethods  AddMemoryPressure CancelFullGCNotification
    syn keyword csBuiltInMethods  Collect CollectionCount EndNoGCRegion
    syn keyword csBuiltInMethods  GetAllocatedBytesForCurrentThread
    syn keyword csBuiltInMethods  GetGeneration GetTotalMemory KeepAlive
    syn keyword csBuiltInMethods  RegisterForFullGCNotification
    syn keyword csBuiltInMethods  RemoveMemoryPressure ReRegisterForFinalize
    syn keyword csBuiltInMethods  SupressFinalize TryStartNoGCRegion
    syn keyword csBuiltInMethods  WaitForFullGCApproach WaitForPendingFinalizers
    "syn keyword csBuiltInProp     MaxGeneration
    " Lazy
    syn keyword csBuiltInMethods  ToString
    "syn keyword csBuiltInProp     IsValueCreated Metadata Value
    " LoaderOptimizationAttribute
    "syn keyword csBuiltInProp     Value
    " LocalDataStoreSlot
    syn keyword csBuiltInMethods  Finalize
    " Math
    syn keyword csBuiltInFields   E PI
    syn keyword csBuiltInMethods  Abs Acos Asin Atan Atan2 BigMul Ceiling Cos
    syn keyword csBuiltInMethods  Cosh DivRem Exp Floor IEEERemainder Log Log10
    syn keyword csBuiltInMethods  Max Min Pow Round Sign Sin Sinh Sqrt Tan Tanh
    syn keyword csBuiltInMethods  Truncate
    " MissingMemberException
    syn keyword csBuiltInFields   ClassName MemberName Signature
    syn keyword csBuiltInMethods  GetObjectData
    "syn keyword csBuiltInProp     Message
    " MissingMethodException
    "syn keyword csBuiltInProp     Message
    " MulticastDelegate
    syn keyword csBuiltInExtMethods GetMethodInfo
    syn keyword csBuiltInMethods  CombineImpl Equals GetHashCode GetInvocationList
    syn keyword csBuiltInMethods  GetMethodImpl GetObjectData RemoveImpl
    syn keyword csBuiltInOperators  Equality Inequality
    " NotFiniteNumberException
    syn keyword csBuiltInMethods  GetObjectData
    "syn keyword csBuiltInProp     OffendingNumber
    " Nullable
    syn keyword csBuiltInMethods  Compare Equals GetUnderlying
    " ObjectDisposedExceptionn
    syn keyword csBuiltInMethods  GetObjectData
    "syn keyword csBuiltInProp     Message ObjectName
    " ObsoleteAttribute
    "syn keyword csBuiltInProp     IsError Message
    " OperatingSystem
    syn keyword csBuiltInMethods  Clone GetObjectData ToString
    "syn keyword csBuiltInProp     Platform ServicePack Version VersionString
    " OperationCancledException
    "syn keyword csBuiltInProp     CancellationToken
    " Progress
    syn keyword csBuiltInEvents   ProgressChanged
    syn keyword csBuiltInMethods  OnReport
    " Random
    syn keyword csBuiltInMethods  Next NextDouble Sample
    " ResolveEventArgs
    "syn keyword csBuiltInProp     Name RequestingAssembly
    " String
    syn keyword csBuiltInFields   Empty
    " This had Contains, but I think there was an error..
    syn keyword csBuiltInMethods  Clone Compare CompareTo Concat Copy
    syn keyword csBuiltInMethods  CopyTo EndsWith Equals Format GetEnumerator
    syn keyword csBuiltInMethods  GetHashCode IndexOf IndexOfAny Insert Intern
    syn keyword csBuiltInMethods  IsInterned IsNormalized IsNullOrEmpty
    syn keyword csBuiltInMethods  IsNullOrWhiteSpace Join LastIndexOf
    syn keyword csBuiltInMethods  LastIndexOfAny Normalize PadLeft PadRight
    syn keyword csBuiltInMethods  Remove Replace Split StartsWith Substring
    syn keyword csBuiltInMethods  ToCharArray ToLower ToLowerInvariant ToUpper
    syn keyword csBuiltInMethods  ToUpperInvariant Trim
    "syn keyword csBuiltInProp     Chars Length
    " StrinngComparer
    syn keyword csBuiltInMethods  Compare Create
    "syn keyword csBuiltInProp     CurrentCulture CurrentCultureIgnoreCase
    "syn keyword csBuiltInProp     InvariantCulture InvariantCultureIgnoreCase
    "syn keyword csBuiltInProp     Ordinal OrdinalIgnoreCase
    " StringNormalizationExtensions
    syn keyword csBuiltInMethods  IsNormalized Normalize
    " TimeZone
    " XXX This Class is Obsolete
    syn keyword csBuiltInMethods  GetDaylightChanges GetUtcOffset
    syn keyword csBuiltInMethods  IsDaylightSavingTime ToLocalTime
    syn keyword csBuiltInMethods  ToUniversalTime
    "syn keyword csBuiltInProp     CurrentTimeZone DaylightName StandardName
    " TimeZoneInfo
    syn keyword csBuiltInMethods  ClearCacheData ConvertTime
    syn keyword csBuiltInMethods  ConvertTimeBySystemTimeZoneId ConvertTimeFromUtc
    syn keyword csBuiltInMethods  ConnvertTimeToUtc CreateCustomTimeZone Equals
    syn keyword csBuiltInMethods  FindSystemTimeZoneById FromSerializedString
    syn keyword csBuiltInMethods  GetAdjustmentRules GetAmbigousTimeOffset
    syn keyword csBuiltInMethods  GetHashCode GetSystemTimeZones GetUtcOffset
    syn keyword csBuiltInMethods  HasSameRules IsAmbigousTime IsDaylightSavingTime
    syn keyword csBuiltInMethods  IsInvalidTime ToSerializedString ToString
    "syn keyword csBuiltInProp     BaseUtcOffset DaylightName DisplayName Id Local
    "syn keyword csBuiltInProp     StandardName SupportsDaylightSavingTime Utc
    " TimeZoneInfo.AdjustmentRule
    syn keyword csBuiltInMethods  CreateAdjustmentRule GetHashCode
    "syn keyword csBuiltInProp     DateEnd DateStart DaylightDelta
    "syn keyword csBuiltInProp     DaylightTransitionEnd DaylightTransitionStart
    " Tuple
    syn keyword csBuiltInMethods  Create Equals GetHashCode ToString
    "syn keyword csBuiltInProp     Item1 Item2 Item3 Item4 Item5 Item6 Item7 Rest
    " TupleExtensions
    syn keyword csBuiltInMethods  Deconstruct ToTuple ToValueTuple
    " Type
    syn keyword csBuiltInFields   Delimiter EmptyTypes FilterAttribute FilterName
    syn keyword csBuiltInFields   FilterNameIgnoreCase Missing
    syn keyword csBuiltInMethods  Equals FindInterfaces FindMembers
    syn keyword csBuiltInMethods  GetArrayRank GetAttributeFlagsImpl
    syn keyword csBuiltInMethods  GetConstructor GetConstructors
    syn keyword csBuiltInMethods  GetCustomAttributes GetCustomAttirbutesData
    syn keyword csBuiltInMethods  GetDefaultMembers GetElementType GetEnumName
    syn keyword csBuiltInMethods  GetEnumNames GetEnumUnderlyingType
    syn keyword csBuiltInMethods  GetEnumValues GetEvent GetEvents GetField
    syn keyword csBuiltInMethods  GetFields GetGenericArguments
    syn keyword csBuiltInMethods  GetGenericParameterConstrainnts
    syn keyword csBuiltInMethods  GetGenericTypeDefinition GetHashCode
    syn keyword csBuiltInMethods  GetInterface GetInterfaceMap GetInterfaces
    syn keyword csBuiltInMethods  GetMember GetMembers GetMethod GetMethodImpl
    syn keyword csBuiltInMethods  GetMethods GetNestedType GetNestedTypes
    syn keyword csBuiltInMethods  GetProperties GetProperty GetPropertyImpl
    syn keyword csBuiltInMethods  GetType GetTypeArray GetTypeCode GetTypeCodeImpl
    syn keyword csBuiltInMethods  GetTypeFromCLSID GetTypeFromHandle
    syn keyword csBuiltInMethods  GetTypeFromProgID GetTypeHandle
    syn keyword csBuiltInMethods  HasElementTypeImpl InvokeMember IsArrayImpl
    syn keyword csBuiltInMethods  IsAssignableFrom IsByRefImpl IsCOMObjectImpl
    syn keyword csBuiltInMethods  IsContextfulImpl IsDefined IsEnumDefined
    syn keyword csBuiltInMethods  IsEquivalentTo IsInstanceOfType
    syn keyword csBuiltInMethods  IsMarshalByRefImpl IsPointerImpl IsPrimitiveImpl
    syn keyword csBuiltInMethods  IsSubclassof IsValueTypeImpl MakeArrayType
    syn keyword csBuiltInMethods  MakeByRefType MakeGenericType MakePointerType
    syn keyword csBuiltInMethods  ReflectionOnlyGetType ToString
    "syn keyword csBuiltInProp     Assembly AssemlyQualifiedName Attributes
    "syn keyword csBuiltInProp     BaseType ContainsGenericParameters
    "syn keyword csBuiltInProp     CustomAttributes DeclaringMethod DeclaringType
    "syn keyword csBuiltInProp     DefaultBinder FullName
    "syn keyword csBuiltInProp     GenericParameterAttributes
    "syn keyword csBuiltInProp     GenericParameterPosition GenericTypeArguments
    "syn keyword csBuiltInProp     GUID HasElementType IsAbstract IsAnsiClass
    "syn keyword csBuiltInProp     IsArray IsAutoClass IsAutoLayout IsByRef IsClass
    "syn keyword csBuiltInProp     IsCOMObject IsConstructedGenericType IsContexful
    "syn keyword csBuiltInProp     IsEnum IsExplicitLayout IsGenericParameter
    "syn keyword csBuiltInProp     IsGenericType IsGenericTypeDefinition IsImport
    "syn keyword csBuiltInProp     IsInterface IsLyaoutSequential IsMarshalByRef
    "syn keyword csBuiltInProp     IsNested IsNestedAssembly IsNestedFamANDAssem
    "syn keyword csBuiltInProp     IsNestedFamily IsNestedPrivate IsNestedPublic
    "syn keyword csBuiltInProp     IsNotPublic IsPointer IsPrimitive IsPublic
    "syn keyword csBuiltInProp     IsSealed IsSecurityCritical
    "syn keyword csBuiltInProp     IsSecuritySafeCritical IsSecurityTransparent
    "syn keyword csBuiltInProp     IsSerializable IsSpecialName IsUnicodeClass
    "syn keyword csBuiltInProp     IsValueType IsVisible MemberType MetadataToken
    "syn keyword csBuiltInProp     Module Namespace ReflectedType
    "syn keyword csBuiltInProp     StructLayoutAttribute TypeHandle TypeInitializer
    "syn keyword csBuiltInProp     UnderlyingSystemType
    " TypeInitializationException
    syn keyword csBuiltInMethods  GetObjectData
    "syn keyword csBuiltInProp     TypeName
    " TypeLoadException
    syn keyword csBuiltInMethods  GetObjectData
    "syn keyword csBuiltInProp     Message TypeName
    " UnhandledExceptionEventArgs
    "syn keyword csBuiltInProp     ExceptionObject IsTerminating
    " Uri
    syn keyword csBuiltInFields   SchemeDelimiter UriSchemeFile UriSchemeFtp
    syn keyword csBuiltInFields   UriSchemeGopher UriSchemeHttp UriSchemeHttps
    syn keyword csBuiltInFields   UriSchemeMailTo UriSchemeNetPipe UriSchemeNetTcp
    syn keyword csBuiltInFields   UriSchemeNews UriSchemeNntp
    syn keyword csBuiltInMethods  Canonicalize CheckHostName CheckSchemeName
    syn keyword csBuiltInMethods  CheckSecurity Compare Equals Escape
    syn keyword csBuiltInMethods  EscapeDataString EscapeString EscapeUriString
    syn keyword csBuiltInMethods  FromHex GetComponents GetHashCode GetLeftPart
    syn keyword csBuiltInMethods  GetObjectData HexEscape HexUnescape
    syn keyword csBuiltInMethods  IsBadFileSystemCharacter IsBaseOf
    syn keyword csBuiltInMethods  IsExcludedCharacter IsHexDigit IsHexEncoding
    syn keyword csBuiltInMethods  IsReservedCharacter IsWellFormedOriginalString
    syn keyword csBuiltInMethods  IsWellFormedUriStrinng MakeRelative
    syn keyword csBuiltInMethods  MakeRelativeUri Parse ToString TryCreate
    syn keyword csBuiltInMethods  Unescape UnescapeDataString
    "syn keyword csBuiltInProp     AbsolutePath AbsoluteUri Authority DnsSafeHost
    "syn keyword csBuiltInProp     Fragment Host HostNameType IdnHost IsAbsoluteUri
    "syn keyword csBuiltInProp     IsDefaultPort IsFile IsLoopback IsUnc LocalPath
    "syn keyword csBuiltInProp     OriginalString PathAndQuery Port Query Scheme
    "syn keyword csBuiltInProp     Segments UserEscaped UserInfo
    syn keyword csBuiltInOperators  Equality Inequality
    " UriBuilder
    syn keyword csBuiltInMethods  Equals GetHashCode ToString
    "syn keyword csBuiltInProp     Fragment Host Password Path Port Query Scheme
    "syn keyword csBuiltInProp     Uri UserName
    " UriTemplate
    syn keyword csBuiltInMethods  BindByName BindByPosition IsEquivilentTo Match
    syn keyword csBuiltInMethods  ToString
    "syn keyword csBuiltInProp     Defaults IgnoreTrailingSlash
    "syn keyword csBuiltInProp     PathSegmentVariableNames QueryValueVariableNames
    " UriTemplateMatch
    "syn keyword csBuiltInProp     BaseUri BoundVariables Data QueryParameters
    "syn keyword csBuiltInProp     RelativePathSegments RequestUri Template
    "syn keyword csBuiltInProp     WildcardPathSegments
    " UriTemplateTable
    syn keyword csBuiltInMethods  MakeReadOnly Match MatchSingle
    "syn keyword csBuiltInProp     BaseAddress IsReadOnly KeyValuePairs
    "syn keyword csBuiltInProp     OriginalBaseAddress
    " UriTypeCOnverter
    syn keyword csBuiltInMethods  IsValid
    " ValueType
    syn keyword csBuiltInMethods  Equals GetHashCode ToString
    " Version
    syn keyword csBuiltInMethods  Clone CompareTo Equals GetHashCode Parse
    syn keyword csBuiltInMethods  ToString TryParse
    "syn keyword csBuiltInProp     Build Major MajorRevision Minor MinorRevision
    "syn keyword csBuiltInProp     Revision
    syn keyword csBuiltInOperators  Equality GreaterThan GreatherOrEqual
    syn keyword csBuiltInOperators  Inequality LessThan LessThanOrEqual
    " WeakReference
    syn keyword csBuiltInMethods  Finalize GetObjectData SetTarget TryGetTarget
    "syn keyword csBuiltInProp     IsAlive Target TrackResurrection
    " Structures
    " ArgIterator
    syn keyword csBuiltInMethods  End Equals GetHashCode GetNextArg GetNextArgType
    syn keyword csBuiltInMethods  GetRemainingCount
    " ArraySegment
    syn keyword csBuiltInMethods  Equals GetHashCode
    "syn keyword csBuiltInProp     Array Count Offset
    syn keyword csBuiltInOperators  Equality Inequality
    " Boolean
    syn keyword csBuiltInFields   FalseString TrueString
    syn keyword csBuiltInMethods  CompareTo Equals GetHashCode GetTypeCode Parse
    syn keyword csBuiltInMethods  ToString TryParse
    " Byte
    " Starting from byte, I'm not going to include duplicate methods, fields,
    "   properties, operators etc for the rest of the structs for namespace
    "   System
    syn keyword csBuiltInFields   MaxValue MinValue
    syn keyword csBuiltInMethods  CompareTo
    " Char
    syn keyword csBuiltInMethods  ConvertFromUtf32 ConvertToUtf32 GetNumericValue
    syn keyword csBuiltInMethods  GetUnicodeCatagory IsControl IsDigit
    syn keyword csBuiltInMethods  IsHighSurrogate IsLetter IsLetterOrDigit
    syn keyword csBuiltInMethods  IsLowSurrogate IsNumber IsPunctuation
    syn keyword csBuiltInMethods  IsSeparator IsSurrogate IsSurrogatePair IsSymbol
    syn keyword csBuiltInMethods  IsUpper IsWhiteSpace ToLower ToLowerInvariant
    syn keyword csBuiltInMethods  ToUpper ToUpperInvariant
    " ConsoleKeyInfo
    "syn keyword csBuiltInProp     Key KeyChar Modifiers
    " DateTime
    syn keyword csBuiltInMethods  Add AddDays AddHours AddMilliseconds AddMinutes
    syn keyword csBuiltInMethods  AddMonths AddSeconds AddTicks AddYears
    syn keyword csBuiltInMethods  DaysInMonth FromBinary FromFileTime
    syn keyword csBuiltInMethods  FromFileTimeUtc FromOADate GetDateTimeFormats
    syn keyword csBuiltInMethods  IsDaylightSavingTime IsLeapYear ParseExact
    syn keyword csBuiltInMethods  SpeficyKind Subtract ToBinary ToFileTime
    syn keyword csBuiltInMethods  ToFileTimeUtc ToLocalTime ToLongDateString
    syn keyword csBuiltInMethods  ToLongTimeString ToOADate ToShortDateString
    syn keyword csBuiltInMethods  ToShortTimeString ToUniversalTime TryParseExact
    "syn keyword csBuiltInProp     Date Day DayOfWeek DayOfYear Hour Kind
    "syn keyword csBuiltInProp     Millisecond Minute Month Now Second Ticks
    "syn keyword csBuiltInProp     TimeOfDay Today UtcNow Year
    syn keyword csBuiltInOperators  Addition Equality GreaterThan
    syn keyword csBuiltInOperators  GreaterThanOrEqual Inequality LessThan
    syn keyword csBuiltInOperators  LessThanOrEqual Subtraction
    " DateTimeOffset
    syn keyword csBuiltInMethods  EqualsExact FromUnixTimeMilliseconds
    syn keyword csBuiltInMethods  FromUnixTimeSconds ToOffset
    syn keyword csBuiltInMethods  ToUnixTimeMilliseconds ToUnixTimeSeconds
    "syn keyword csBuiltInProp     LocalDateTime Offset UtcTicks
    " Decimal
    syn keyword csBuiltInFields   MinusOne One Zero
    syn keyword csBuiltInMethods  Ceiling Floor FromOACurrency GetBits Multiply
    syn keyword csBuiltInMethods  Negate Remainder Round ToByte ToDouble ToInt16
    syn keyword csBuiltInMethods  ToInt32 ToInt64 ToOACurrenct ToSByte ToSingle
    syn keyword csBuiltInMethods  ToUInt16 ToUInt32 ToUInt64 Truncate
    syn keyword csBuiltInOperators  Decrement Division Explicit Implicit
    syn keyword csBuiltInOperators  Increment Modulus Multiply UnaryNegation
    syn keyword csBuiltInOperators  UnaryPlus
    " Double
    syn keyword csBuiltInFields   Epsilon NaN NegativeInfinity PositiveInfinity
    syn keyword csBuiltInMethods  IsInfinity IsNane IsNegativeInfinity
    syn keyword csBuiltInMethods  IsPositiveInfinity
    " Guid
    "syn keyword csBuiltInFields   Empty
    syn keyword csBuiltInMethods  NewGuid ToByteArray
    " IntPtr
    "syn keyword csBuiltInProp     Size
    syn keyword csBuiltInMethods  ToPointer
    " ModuleHandle
    syn keyword csBuiltInFields   EmptyHandle
    syn keyword csBuiltInMethods  GetRuntimeFieldHandleFromMetadataToken
    syn keyword csBuiltInMethods  GetRuntimeMethodHandleFromMetadataToken
    syn keyword csBuiltInMethods  GetRuntimeTypeHandleFromMetadataToken
    syn keyword csBuiltInMethods  ResolveFieldHandle ResolveMethodHandle
    syn keyword csBuiltInMethods  ResolveTypeHandle
    "syn keyword csBuiltInProp     MDStreamVersion
    " Nullable
    syn keyword csBuiltInMethods  GetValueOrDefault
    "syn keyword csBuiltInProp     HasValue Value
    " RuntimeMethodHandle
    syn keyword csBuiltInMethods  GetFunctionPointer
    " RuntimeTypeHandle
    syn keyword csBuiltInMethods  GetModuleHandle
    " TimeSpan
    syn keyword csBuiltInFields   TicksPerDay TicksPerHour TicksPerMillisecond
    syn keyword csBuiltInFields   TicksPerMinute TicksPerSecond
    syn keyword csBuiltInMethods  FromDays FromHours FromMilliseconds FromMinutes
    syn keyword csBuiltInMethods  FromSeconds FromTicks
    "syn keyword csBuiltInProp     TotalDays TotalHours TotalMillseconds
    "syn keyword csBuiltInProp     TotalMinutes TotalSeconds
    " TimeZoneInfo.TransitionTime
    syn keyword csBuiltInMethods  CreateFixedDateRule CreateFloatingDateRule
    "syn keyword csBuiltInProp     IsFixedDateRule
    " TypedReference
    syn keyword csBuiltInMethods  GetTargetType MakeTypedReference
    syn keyword csBuiltInMethods  SetTypedReference TargetTypeToken ToObject
    " ValueTuple
    syn keyword csBuiltInFields   Item1 Item2 Item3 Item4 Item5 Item6 Item7 Rest
    syn keyword csBuiltInMethods  Create

    syn keyword csObsolete ContextMarshallException ExecutionEngineException
    syn keyword csObsolete TimeZone

  for l:p in ['AbsolutePath', 'AbsoluteUri', 'ActivationArguments', 'ActivationContext',
      \ 'ActivationTrust', 'ActualValue', 'AllowMultiple', 'AppDomainInitializer',
      \ 'AppDomainInitializerArguments', 'AppDomainMangerAssembly',
      \ 'AppDomainMangerType', 'ApplicationActivator', 'ApplicationBase',
      \ 'ApplicationIdentity', 'ApplicationManifestBytes', 'ApplicationName',
      \ 'ApplicatoinTrust', 'ArgumentCound', 'Array', 'Assembly',
      \ 'AssemlyQualifiedName', 'Attributes', 'Authority', 'Backgroun dColor',
      \ 'BaseAddress', 'BaseDirectory', 'BaseType', 'BaseUri', 'BaseUtcOffset',
      \ 'BoundVariables', 'BufferHeight', 'BufferWidth', 'Build', 'CachePath',
      \ 'Cancel', 'CancellationToken', 'CapsLock', 'Chars', 'CodeBase', 'CommandLine',
      \ 'C onfigurationFile', 'ContainsGenericParameters', 'Count', 'Culture',
      \ 'CurosrVisible', 'Current', 'CurrentCulture', 'CurrentCultureIgnoreCase',
      \ 'CurrentDirectory', 'CurrentDomain', 'CurrentManagedThreadId',
      \ 'CurrentTimeZone', 'CursorLe ft', 'CursorSize', 'CursorTop',
      \ 'CustomAttributes', 'Data', 'Date', 'DateEnd', 'DateStart', 'Day', 'DayOfWeek',
      \ 'DayOfYear', 'DaylightDelta', 'DaylightName', 'DaylightTransitionEnd',
      \ 'DaylightTransitionStart', 'DeclaringMethod', 'Dec laringType',
      \ 'DefaultBinder', 'Defaults', 'DeploymentManifestBytes',
      \ 'DisallowApplicationBaseProbing', 'DisallowBindingRedirects',
      \ 'DisallowCodeDownload', 'DisallowPublicPolicy', 'DisplayName', 'DnsSafeHost',
      \ 'DomainManager', 'Dynami cBase', 'DynamicDirectory', 'Empty', 'EntryAssembly',
      \ 'Error', 'Evidence', 'ExceptionObject', 'ExitCode', 'FileName',
      \ 'ForegroundColor', 'Form', 'Format', 'Fragment', 'FriendlyName', 'FullName',
      \ 'FustionLog', 'GUID', 'GenericParamete rAttributes',
      \ 'GenericParameterPosition', 'GenericTypeArguments', 'HResult',
      \ 'HasElementType', 'HasShutdownStarted', 'HasValue', 'HelpLink', 'Host',
      \ 'HostExecutionContextManager', 'HostNameType', 'HostSecurityManager', 'Hour',
      \ 'Id', 'Identity', 'IdnHost', 'IgnoreTrailingSlash', 'In', 'Inherited',
      \ 'InitializingFlags', 'InnerException', 'InnerExceptions', 'InputEncoding',
      \ 'InvariantCulture', 'InvariantCultureIgnoreCase', 'Is64BitOperatingSystem',
      \ 'Is64BitProcess', 'IsAbsoluteUri', 'IsAbstract', 'IsAlive', 'IsAnsiClass',
      \ 'IsArray', 'IsAutoClass', 'IsAutoLayout', 'IsByRef', 'IsCOMObject', 'IsClass',
      \ 'IsCompliant', 'IsConstructedGenericType', 'IsContexful', 'IsDefaultPort',
      \ 'IsEnum', 'IsError', 'IsErrorRedirected', 'IsExplicitLayout', 'IsFile',
      \ 'IsFixedDateRule', 'IsFixedSize', 'IsFullyTrusted', 'IsGenericParameter',
      \ 'IsGenericType', 'IsGenericTypeDefinition', 'IsHomogenous', 'IsImport',
      \ 'IsInputRedirected', 'IsInterface', 'IsLoopback', 'IsLyaoutSequential',
      \ 'IsMarshalByRef', 'IsNested', 'IsNestedAssembly', 'IsNestedFamANDAssem',
      \ 'IsNestedFamily', 'IsNestedPrivate', 'IsNestedPublic', 'IsNotPublic',
      \ 'IsOutputRedirected', 'IsPointer', 'IsPrimitive', 'IsP ublic', 'IsReadOnly',
      \ 'IsSealed', 'IsSecurityCritical', 'IsSecuritySafeCritical',
      \ 'IsSecurityTransparent', 'IsSerializable', 'IsSpecialName', 'IsSyncronized',
      \ 'IsTerminating', 'IsUnc', 'IsUnicodeClass', 'IsValueCreated', 'IsValueType ',
      \ 'IsVisible', 'Item1', 'Item2', 'Item3', 'Item4', 'Item5', 'Item6', 'Item7',
      \ 'Key', 'KeyAvailable', 'KeyChar', 'KeyValuePairs', 'Kind',
      \ 'LargestWindowHeight', 'LargestWinndowWidth', 'Length', 'LicenseFile',
      \ 'LoadedAssembly', 'Loade rOptimization', 'Local', 'LocalDateTime', 'LocalPath',
      \ 'LongLength', 'MDStreamVersion', 'MachineName', 'Major', 'MajorRevision',
      \ 'MaxGeneration', 'MemberType', 'Message', 'Metadata', 'MetadataToken',
      \ 'Method', 'Millisecond', 'Minor', 'MinorRevision', 'Minute', 'Modifiers',
      \ 'Module', 'MonitoringIsEnabled', 'MonitoringSurvivedMemorySize',
      \ 'MonitoringSurvivedProcessMemorySize', 'MonitoringTotalAllocatedMemorySize',
      \ 'MonitoringTotalProcessorTime', 'Month', 'Name', ' Namespace', 'NewLine',
      \ 'Now', 'NumberLock', 'OSVersion', 'ObjectName', 'OffendingNumber', 'Offset',
      \ 'Ordinal', 'OrdinalIgnoreCase', 'OriginalBaseAddress', 'OriginalString', 'Out',
      \ 'OutputEncoding', 'ParamName', 'PartialTrustVisibleAs semblies', 'Password',
      \ 'Path', 'PathAndQuery', 'PathSegmentVariableNames', 'PermissionSet',
      \ 'Platform', 'Port', 'PrivateBinPath', 'PrivateBinPathProbe',
      \ 'ProcessorArchitecture', 'ProcessorCound', 'PublicKeyToken', 'Query',
      \ 'QueryPara meters', 'QueryValueVariableNames', 'Rank', 'ReflectedType',
      \ 'RelativePathSegments', 'RelativeSearchPath', 'RequestUri',
      \ 'RequestingAssembly', 'Rest', 'Revision', 'SandboxInterop', 'Scheme', 'Second',
      \ 'Segments', 'ServicePack', 'Setu pInformation', 'ShadowCopyDirectories',
      \ 'ShadowCopyFiles', 'Size', 'Source', 'SpecialKey', 'StackTrace',
      \ 'StandardName', 'StructLayoutAttribute', 'SupportsDaylightSavingTime',
      \ 'SyncRoot', 'SystemDirectory', 'SystemPageSize', 'Target' ,
      \ 'TargetFrameworkName', 'TargetSite', 'Template', 'TickCount', 'Ticks',
      \ 'TimeOfDay', 'Title', 'Today', 'TotalDays', 'TotalHours', 'TotalMillseconds',
      \ 'TotalMinutes', 'TotalSeconds', 'TrackResurrection', 'TreatControlCAsInput',
      \ 'Type Handle', 'TypeId', 'TypeInitializer', 'TypeName', 'UnderlyingSystemType',
      \ 'Uri', 'UserDomainName', 'UserEscaped', 'UserInfo', 'UserInteractive',
      \ 'UserName', 'Utc', 'UtcNow', 'UtcTicks', 'ValidOn', 'Value', 'Version',
      \ 'VersionString', 'WildcardPathSegments', 'WindowHeight', 'WindowLeft',
      \ 'WindowTop', 'WindowWidth', 'WorkingSet', 'Year']
    execute 'syn match csBuiltInProp /\%(long\|int\%(16\|32\|64\)\?\)\<\' . l:p . '\>/'
  endfor

  endif
endfunction
hi def link csBuiltInClass      class
hi def link csBuiltInEnums      enumName
hi def link csBuiltInFields     field
" FIXME Change this; needs a group created for it
hi def link csBuiltInInterfaces constant
hi def link csBuiltInMethods    method
hi def link csBuiltInOperators  operator
hi def link csBuiltInProp       property
hi def link csBuiltInStructs    structure


augroup asdf
  autocmd!
  autocmd BufEnter,BufWrite *.cs call s:test()
augroup END

call UCTags#Utils#HiLink('cs')
" This causes a recursive loop...
"execute 'runtime! syntax/cs.vim'
