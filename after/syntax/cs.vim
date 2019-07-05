" File:         cs.vim
" Last Change:  07/04/2019
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

    " TODO Look at 'Type Handle'
    for l:p in ['AbsolutePath', 'AbsoluteUri', 'ActivationArguments',
          \ 'ActivationContext', 'ActivationTrust', 'ActualValue',
          \ 'AllowMultiple', 'AppDomainInitializer',
          \ 'AppDomainInitializerArguments',
          \ 'AppDomainMangerAssembly', 'AppDomainMangerType',
          \ 'ApplicationActivator', 'ApplicationBase', 'ApplicationIdentity',
          \ 'ApplicationManifestBytes', 'ApplicationName', 'ApplicatoinTrust',
          \ 'ArgumentCound', 'Array', 'Assembly', 'AssemlyQualifiedName',
          \ 'Attributes', 'Authority', 'Backgroun dColor', 'BaseAddress',
          \ 'BaseDirectory', 'BaseType', 'BaseUri', 'BaseUtcOffset',
          \ 'BoundVariables', 'BufferHeight', 'BufferWidth', 'Build',
          \ 'CachePath', 'Cancel', 'CancellationToken', 'CapsLock', 'Chars',
          \ 'CodeBase', 'CommandLine', 'C onfigurationFile',
          \ 'ContainsGenericParameters', 'Count', 'Culture', 'CurosrVisible',
          \ 'Current', 'CurrentCulture', 'CurrentCultureIgnoreCase',
          \ 'CurrentDirectory', 'CurrentDomain', 'CurrentManagedThreadId',
          \ 'CurrentTimeZone', 'CursorLe ft', 'CursorSize', 'CursorTop',
          \ 'CustomAttributes', 'Data', 'Date', 'DateEnd', 'DateStart', 'Day',
          \ 'DayOfWeek', 'DayOfYear', 'DaylightDelta', 'DaylightName',
          \ 'DaylightTransitionEnd', 'DaylightTransitionStart',
          \ 'DeclaringMethod', 'Dec laringType', 'DefaultBinder', 'Defaults',
          \ 'DeploymentManifestBytes', 'DisallowApplicationBaseProbing',
          \ 'DisallowBindingRedirects', 'DisallowCodeDownload',
          \ 'DisallowPublicPolicy', 'DisplayName', 'DnsSafeHost',
          \ 'DomainManager', 'Dynami cBase', 'DynamicDirectory', 'Empty',
          \ 'EntryAssembly', 'Error', 'Evidence', 'ExceptionObject', 'ExitCode',
          \ 'FileName', 'ForegroundColor', 'Form', 'Format', 'Fragment',
          \ 'FriendlyName', 'FullName', 'FustionLog', 'GUID',
          \ 'GenericParameterAttributes', 'GenericParameterPosition',
          \ 'GenericTypeArguments', 'HResult', 'HasElementType',
          \ 'HasShutdownStarted', 'HasValue',
          \ 'HelpLink', 'Host', 'HostExecutionContextManager', 'HostNameType',
          \ 'HostSecurityManager', 'Hour', 'Id', 'Identity', 'IdnHost',
          \ 'IgnoreTrailingSlash', 'In', 'Inherited', 'InitializingFlags',
          \ 'InnerException', 'InnerExceptions', 'InputEncoding',
          \ 'InvariantCulture', 'InvariantCultureIgnoreCase',
          \ 'Is64BitOperatingSystem', 'Is64BitProcess', 'IsAbsoluteUri',
          \ 'IsAbstract', 'IsAlive', 'IsAnsiClass', 'IsArray', 'IsAutoClass',
          \ 'IsAutoLayout', 'IsByRef', 'IsCOMObject', 'IsClass', 'IsCompliant',
          \ 'IsConstructedGenericType', 'IsContexful', 'IsDefaultPort', 'IsEnum',
          \ 'IsError', 'IsErrorRedirected', 'IsExplicitLayout', 'IsFile',
          \ 'IsFixedDateRule', 'IsFixedSize', 'IsFullyTrusted',
          \ 'IsGenericParameter', 'IsGenericType', 'IsGenericTypeDefinition',
          \ 'IsHomogenous', 'IsImport', 'IsInputRedirected', 'IsInterface',
          \ 'IsLoopback', 'IsLyaoutSequential', 'IsMarshalByRef', 'IsNested',
          \ 'IsNestedAssembly', 'IsNestedFamANDAssem', 'IsNestedFamily',
          \ 'IsNestedPrivate', 'IsNestedPublic', 'IsNotPublic',
          \ 'IsOutputRedirected', 'IsPointer', 'IsPrimitive', 'IsP ublic',
          \ 'IsReadOnly', 'IsSealed', 'IsSecurityCritical',
          \ 'IsSecuritySafeCritical', 'IsSecurityTransparent', 'IsSerializable',
          \ 'IsSpecialName', 'IsSyncronized', 'IsTerminating', 'IsUnc',
          \ 'IsUnicodeClass', 'IsValueCreated', 'IsValueType ', 'IsVisible',
          \ 'Item1', 'Item2', 'Item3', 'Item4', 'Item5', 'Item6', 'Item7', 'Key',
          \ 'KeyAvailable', 'KeyChar', 'KeyValuePairs', 'Kind',
          \ 'LargestWindowHeight', 'LargestWinndowWidth', 'Length',
          \ 'LicenseFile', 'LoadedAssembly', 'Loade rOptimization', 'Local',
          \ 'LocalDateTime', 'LocalPath', 'LongLength', 'MDStreamVersion',
          \ 'MachineName', 'Major', 'MajorRevision', 'MaxGeneration',
          \ 'MemberType', 'Message', 'Metadata', 'MetadataToken', 'Method',
          \ 'Millisecond', 'Minor', 'MinorRevision', 'Minute', 'Modifiers',
          \ 'Module', 'MonitoringIsEnabled', 'MonitoringSurvivedMemorySize',
          \ 'MonitoringSurvivedProcessMemorySize',
          \ 'MonitoringTotalAllocatedMemorySize', 'MonitoringTotalProcessorTime',
          \ 'Month', 'Name', ' Namespace', 'NewLine', 'Now', 'NumberLock',
          \ 'OSVersion', 'ObjectName', 'OffendingNumber', 'Offset', 'Ordinal',
          \ 'OrdinalIgnoreCase', 'OriginalBaseAddress', 'OriginalString', 'Out',
          \ 'OutputEncoding', 'ParamName', 'PartialTrustVisibleAs semblies',
          \ 'Password', 'Path', 'PathAndQuery', 'PathSegmentVariableNames',
          \ 'PermissionSet', 'Platform', 'Port', 'PrivateBinPath',
          \ 'PrivateBinPathProbe', 'ProcessorArchitecture', 'ProcessorCound',
          \ 'PublicKeyToken', 'Query', 'QueryPara meters',
          \ 'QueryValueVariableNames', 'Rank', 'ReflectedType',
          \ 'RelativePathSegments', 'RelativeSearchPath', 'RequestUri',
          \ 'RequestingAssembly', 'Rest', 'Revision', 'SandboxInterop', 'Scheme',
          \ 'Second', 'Segments', 'ServicePack', 'Setu pInformation',
          \ 'ShadowCopyDirectories', 'ShadowCopyFiles', 'Size', 'Source',
          \ 'SpecialKey', 'StackTrace', 'StandardName', 'StructLayoutAttribute',
          \ 'SupportsDaylightSavingTime', 'SyncRoot', 'SystemDirectory',
          \ 'SystemPageSize', 'Target' , 'TargetFrameworkName', 'TargetSite',
          \ 'Template', 'TickCount', 'Ticks', 'TimeOfDay', 'Title', 'Today',
          \ 'TotalDays', 'TotalHours', 'TotalMillseconds', 'TotalMinutes',
          \ 'TotalSeconds', 'TrackResurrection', 'TreatControlCAsInput',
          \ 'Type Handle', 'TypeId', 'TypeInitializer', 'TypeName',
          \ 'UnderlyingSystemType', 'Uri', 'UserDomainName', 'UserEscaped',
          \ 'UserInfo', 'UserInteractive', 'UserName', 'Utc', 'UtcNow',
          \ 'UtcTicks', 'ValidOn', 'Value', 'Version', 'VersionString',
          \ 'WildcardPathSegments', 'WindowHeight', 'WindowLeft', 'WindowTop',
          \ 'WindowWidth', 'WorkingSet', 'Year']
      " FIXME TODO This needs to be improved, there is a lot more types a
      "   property can be.
      if len(filter(getline(1, line('$')), "v:val =~# '\\.\\zs" . l:p . "\\>\\s*\\((\\)\\@!'"))
      "if len(filter(getline(1, line('$')), "v:val =~# '\\%(long\\|int\\%(16\\|32\\|64\\)\?\\)\<\\" . l:p . "\\>'"))
        execute 'syn match csBuiltInProp /\.\zs' . l:p . '\>\s*\((\)\@!/'
        "execute 'syn match csBuiltInProp /\%(long\|int\%(16\|32\|64\)\?\)\<\' . l:p . '\>/'
      endif
    endfor
    for l:e in ['Loose', 'StoreBounded', 'None', 'RegisterWithHost', 'All',
          \ 'Assembly', 'Class', 'Constructor', 'Delegate', 'Enum', 'Event',
          \ 'Field', 'GenericParameter', 'Interface', 'Method', 'Module',
          \ 'Parameter', 'Property', 'ReturnValue', 'Struct', 'InsertLineBreaks',
          \ 'Black', 'Blue', 'Cyan', 'DarkBlue', 'DarkCyan', 'DarkGray',
          \ 'DarkGreen', 'DarkMagenta', 'DarkRed', 'DarkYellow', 'Gray', 'Green',
          \ 'Magenta', 'Red', 'White', 'Yellow', 'A', 'Add', 'Applications',
          \ 'Attention', 'B', 'Backspace', 'BrowserBack', 'BrowserFavorites',
          \ 'BrowserForward', 'BrowserHome', 'BrowserRefresh', 'BrowserSearch',
          \ 'BrowserStop', 'C', 'Clear', 'CrSel', 'D', 'D0', 'D1', 'D2', 'D3',
          \ 'D4', 'D4', 'D5', 'D6', 'D6', 'D7', 'D8', 'D9', 'Decimal', 'Delete',
          \ 'Delete', 'Divide', 'DownArrow', 'E', 'End', 'Enter', 'EraseEndOfFile',
          \ 'Escape', 'Execute', 'ExSel', 'F', 'F1', 'F10', 'F11', 'F12', 'F13',
          \ 'F14', 'F15', 'F16', 'F17', 'F18', 'F19', 'F2', 'F20', 'F21', 'F22',
          \ 'F23', 'F24', 'F3', 'F4', 'F5', 'F6', 'F7', 'F8', 'F9', 'G', 'H',
          \ 'Help', 'Home', 'I', 'Insert', 'J', 'K', 'L', 'LaunchApp1',
          \ 'LaunchApp2', 'LaunchMail', 'LaunchMediaSelect', 'LeftArrow',
          \ 'LeftWindows', 'M', 'MediaNext', 'MediaPlay', 'MediaPrevious',
          \ 'MediaStop', 'Multiply', 'N', 'NoName', 'NumPad0', 'NumPad1',
          \ 'NumPad2', 'NumPad3', 'NumPad4', 'NumPad5', 'NumPad6', 'NumPad7',
          \ 'NumPad8', 'NumPad9', 'O', 'Oem1', 'Oem102', 'Oem2', 'Oem3', 'Oem4',
          \ 'Oem4', 'Oem5', 'Oem6', 'Oem7', 'Oem8', 'OemClear', 'OemComma',
          \ 'OemMinus', 'OemPeriod', 'OemPlus', 'P', 'Pa1', 'Packet', 'PageDown',
          \ 'PageUp', 'Pause', 'Play', 'Print', 'PrintScreen', 'Process', 'Q', 'R',
          \ 'RightArrow', 'RightWindows', 'S', 'Select', 'Separator', 'Sleep',
          \ 'Sleep', 'Spacebar', 'Subtract', 'T', 'Tab', 'U', 'UpArrow', 'V',
          \ 'VolumeDown', 'VolumeMute', 'VolumeUp', 'W', 'X', 'Y', 'Z', 'Zoom',
          \ 'Alt', 'Control', 'Shift', 'ControlBreak', 'ControlC', 'Local',
          \ 'Unspecified', 'Utc', 'Friday', 'Monday', 'Saturday', 'Sunday',
          \ 'Thursday', 'Tuesday', 'Wednesday', 'AdminTools', 'ApplicationData',
          \ 'CDBurning', 'CommonAdminTools', 'CommonApplicationData',
          \ 'CommonDesktopDirectory', 'CommonDocuments', 'CommonMusic',
          \ 'CommonOemLinks', 'CommonPictures', 'CommonProgramFiles',
          \ 'CommpongProgramFilesX86', 'CommponPrograms', 'CommonStartMenu',
          \ 'CommonStartup', 'CommonTemplates', 'CommonVideos', 'Cookies',
          \ 'Desktop', 'DesktopDirectory', 'Favorites', 'Fonts', 'History',
          \ 'InternetCache', 'LocalApplicationData', 'LocalizedResources',
          \ 'MyComputer', 'MyDocuments', 'MyMusic', 'MyPictures', 'MyVideos',
          \ 'NetworkShortcuts', 'Personal', 'PrinterShortcuts', 'ProgramFiles',
          \ 'ProgramFilesX86', 'Programs', 'Recent', 'Resources', 'SentTo',
          \ 'StartMenu', 'StartUp', 'System', 'SystemX86', 'Templates',
          \ 'UserProfile', 'Windows', 'Create', 'DoNotVerify', 'Machine',
          \ 'Process', 'User', 'Default', 'Forced', 'Optimized', 'Canceled',
          \ 'Failed', 'NotApplicable', 'Succeeded', 'Timeout',
          \ 'AllowEmptyAuthority', 'DontCompressPath', 'DontConvertPathBackslashes',
          \ 'DontUnescapePathDotsAndSlashes', 'GenericAuthority', 'Idn',
          \ 'IriParsing', 'NoFragment', 'NoPort', 'NoQuery', 'NoUserInfo',
          \ 'DissalowBindings', 'DomainMask', 'MultiDomain', 'MultiDomainhost',
          \ 'NotSpeciied', 'SingleDomain', 'AwayFromZero', 'ToEven', 'MacOSX',
          \ 'Unix', 'Win32NT', 'Win32S', 'Win32Windows', 'WinCE', 'Xbox',
          \ 'CurrentCulture', 'CurrentCultureIgnoreCase', 'InvariantCulture',
          \ 'InvariantCultureIgnoreCase', 'Ordinal', 'OrdinalIgnoreCase',
          \ 'RemoveEmptyEntries', 'Boolean', 'Byte', 'Char', 'DateTime', 'DBNull',
          \ 'Decimal', 'Double', 'Empty', 'Int16', 'Int32', 'Int64', 'Object',
          \ 'SByte', 'Single', 'String', 'UInt16', 'UInt32', 'UInt64',
          \ 'AbsoluteUri', 'Fragment', 'Host', 'HostAndPort', 'HttpRequestUrl',
          \ 'KeepDelimiter', 'NormalizedHost', 'Path', 'PathAndQuery', 'Port',
          \ 'Query', 'Scheme', 'SchemeAndServer', 'SerializationInfoString',
          \ 'StrongAuthority', 'StrongPort', 'UserInfo', 'SafeUnescaped',
          \ 'Unescaped', 'UriEscaped', 'Basic', 'Dns', 'IPv4', 'IPv6',
          \ 'Unknown', 'All', 'AllExceptIntranet', 'Absolute', 'Relative',
          \ 'RelativeOrAbsolute', 'Path', 'Query', 'Scheme']
      if len(filter(getline(1, line('$')), "v:val =~# '\\.\\zs" . l:e . "\\>'"))
        execute 'syn match csBuiltInEnumValue /\.\zs' . l:e . '\>/'
      endif
    endfor

  endif
  if len(filter(getline(1, line('$')), "v:val =~# '^\\s*using\\s\\+System\.Diagnostics;'"))
    syn keyword csBuiltInClasses  BooleanSwitch ConditionalAttribute
    syn keyword csBuiltInClasses  ConsoleTraceListener CorrelationManager
    syn keyword csBuiltInClasses  CounterCreationData
    syn keyword csBuiltInClasses  CounterCreateDataCollection
    syn keyword csBuiltInClasses  CounterSimpleCalculator DataRecievedEventArgs
    syn keyword csBuiltInClasses  Debug DebuggableAttribute Debugger
    syn keyword csBuiltInClasses  DebuggerBrowsableAttribute
    syn keyword csBuiltInClasses  DebuggerDisplayAttribute
    syn keyword csBuiltInClasses  DebuggerHiddenAttribute
    syn keyword csBuiltInClasses  DebuggerNonUserCodeAttribute
    syn keyword csBuiltInClasses  DebuggerStepperBoundaryAttribute
    syn keyword csBuiltInClasses  DebuggerStepThroughAttribute
    syn keyword csBuiltInClasses  DebuggerTypeProxyAttribute
    syn keyword csBuiltInClasses  DebuggerVisualizerAttribute
    syn keyword csBuiltInClasses  DefaultTraceListener
    syn keyword csBuiltInClasses  DefaultListTraceListener
    syn keyword csBuiltInClasses  DiagnosticsConfigurationHandler
    syn keyword csBuiltInClasses  EntryWrittenEventArgs EventInstance EventLog
    syn keyword csBuiltInClasses  EventLogEntry EventLogEntryCollection
    syn keyword csBuiltInClasses  EventLogInstaller EvenLogPermission
    syn keyword csBuiltInClasses  EventLogPermissionEntry
    syn keyword csBuiltInClasses  EventLogPermissionEntryEntry
    syn keyword csBuiltInClasses  EventLogTraceListener EventSchemaTraceListener
    syn keyword csBuiltInClasses  EvenSourceCreationData EventTypeFilter
    syn keyword csBuiltInClasses  FileVersionInfo InstanceData
    syn keyword csBuiltInClasses  InstanceDataCollection
    syn keyword csBuiltInClasses  InstanceDataCollectionCollection
    syn keyword csBuiltInClasses  MonitoringDescriptionAttribute
    syn keyword csBuiltInClasses  PerformanceCounter PerformanceCounterCategory
    syn keyword csBuiltInClasses  PerformanceCounterInstaller
    syn keyword csBuiltInClasses  PerformanceCounterManager
    syn keyword csBuiltInClasses  PerformanceCounterPermission
    syn keyword csBuiltInClasses  PerformanceCounterPermissionAttribute
    syn keyword csBuiltInClasses  PerformanceCounterPermissionEntry
    syn keyword csBuiltInClasses  PerformanceCounterPermissionEntryCollection
    syn keyword csBuiltInClasses  PresentationTraceSources Process ProcessModule
    syn keyword csBuiltInClasses  ProcessModuleCollection ProcessStartInfo
    syn keyword csBuiltInClasses  ProcessStartInfo ProcessThread
    syn keyword csBuiltInClasses  ProcessThreadCollection SourceFilter
    syn keyword csBuiltInClasses  SourceSwitch StackFrame StackFrameExtensions
    syn keyword csBuiltInClasses  StackTrace Stopwatch Switch SwitchAttribute
    syn keyword csBuiltInClasses  SwitchLevelAttribute TextWriterTraceListener
    syn keyword csBuiltInClasses  Trace TraceEventCache TraceFilter
    syn keyword csBuiltInClasses  TraceListener TraceListenerCollection
    syn keyword csBuiltInClasses  TraceSource TraceSwitch
    syn keyword csBuiltInClasses  UnescapedXmlDiagnosticData
    syn keyword csBuiltInClasses  XmlWriterTraceListener
    syn keyword csBuiltInStructs  CounterSample
    syn keyword csBuiltInInterfaces ICollectData
    syn keyword csBuiltInEnums      DebuggableAttribute.DebuggingModes
    syn keyword csBuiltInEnums      DebuggerBrowsableState
    syn keyword csBuiltInEnums      EventEntryType EventLogPermissionAccess
    syn keyword csBuiltInEnums      OverflowAction
    syn keyword csBuiltInEnums      PerformanceCounterCategoryType
    syn keyword csBuiltInEnums      PerformanceCounterInstanceLifetime
    syn keyword csBuiltInEnums      PerformanceCounterPermissionAccess
    syn keyword csBuiltInEnums      PerformanceCounterType
    syn keyword csBuiltInEnums      PresentationTraceLevel ProcessPriorityClass
    syn keyword csBuiltInEnums      ProcessWindowStyle SourceLevels
    syn keyword csBuiltInEnums      ThreadPriorityLevel ThreadState
    syn keyword csBuiltInEnums      ThreadWaitReason TraceEventType TraceLevel
    syn keyword csBuiltInEnums      TraceLogRetentionOption TraceOptions
    syn keyword csBuiltInDelegates  DataReceivedEventHandler
    syn keyword csBuiltInDelegates  EntryWrittenEventHandler
    let s:p = ['Attributes', 'Description', 'DisplayName', 'Enabled',
          \ 'SwitchSetting', 'Value', 'ConditionString', 'Filter', 'IndentLevel',
          \ 'IndentSize', 'IsThreadSafe', 'Name', 'NameIndent', 'TraceOutputOptions',
          \ 'ActivityId', 'LogicalOperationStack', 'CounterHelp', 'CounterName',
          \ 'CounterType', 'BaseValue', 'CounterFrequency', 'CouterTimeStamp',
          \ 'RawValue', 'SysmtemFrequency', 'TimeStamp', 'TimeStamp100nSec',
          \ 'ConditionString', 'Writer']
    " CounterSample
    syn keyword csBuiltInFields   Empty
    syn keyword csBuiltInMethods  Calculate
    syn keyword csBuiltInOperators Equality Inequality
    " Switch
    syn keyword csBuiltInMethods  GetSupportedAttributes
    syn keyword csBuiltInMethods  OnSwitchSettingChanged OnValueChanged
    " ConditionalAttribute
    " TraceListener
    syn keyword csBuiltInMethods  Close Dispose Fail Flush TraceData
    syn keyword csBuiltInMethods  TraceEvent WriteIndent
    " CorrelationManager
    syn keyword csBuiltInMethods  StartLogicalOperation StopLogicalOperation
    " CounterCreationData
    syn keyword csBuiltInMethods  Add
    let l:e = ['Default', 'DisableOptimizations', 'EnableEditAndContinue',
          \ 'IgnoreSymbolStoreSequencePoints', 'None', 'Collapsed', 'Never',
          \ 'RootHidden', 'Error', 'FailureAudit', 'Information',
          \ 'SuccessAudit', 'Warning', 'Administer', 'Audit', 'Browse',
          \ 'Instrument', 'Write', 'DoNotOverwrite', 'OverwriteAsNeeded',
          \ 'OverwriteOlder', 'MultiInstance', 'SingleInstance', 'Unknown',
          \ 'Global', 'Process', 'Read', 'Write', 'AverageBase',
          \ 'AverageCount64', 'AverageTimer32', 'CounterDelta32',
          \ 'CounterDelta64', 'CounterMultiBase', 'CounterMultiTimer',
          \ 'CounterMultiTimer100Ns', 'CounterMultiTimer100NsInverse',
          \ 'CounterMultiTimerInverse', 'CounterTimer', 'CounterTimerInverse',
          \ 'CounterPerTimeInterval32', 'CountPerTimeInterval64', 'ElapsedTime',
          \ 'NumberOfItems32', 'NumberOfItems64', 'NumberOfItemsHEX32',
          \ 'NumberOfItemsHEX64', 'RateOfCountsPerSecond32',
          \ 'RateOfCountsPerSecond64', 'RawBase', 'RawFraction', 'SampleBase',
          \ 'SampleCounter', 'SampleFraction', 'Timer100Ns', 'Timer100NsInverse',
          \ 'High', 'Low', 'Medium', 'AboveNormal', 'BelowNormal', 'Idle',
          \ 'Normal', 'RealTime', 'Hidden', 'Maximized', 'Minimized',
          \ 'ActivityTracing', 'All', 'Critical', 'Error', 'Information', 'Off',
          \ 'Verbose', 'Warning', 'Highest', 'Lowest', 'TimeCritical',
          \ 'Initialized', 'Ready', 'Running', 'Standby', 'Terminated',
          \ 'Transition', 'Unknown', 'Wait', 'EventPairHigh', 'EventPairLow',
          \ 'ExecutionDelay', 'Executive', 'FreePage', 'LpcRecive', 'LpcReply',
          \ 'PageIn', 'PageOut', 'Suspended', 'SystemAllocation', 'UserRequest',
          \ 'VirtualMemory', 'Resume', 'Start', 'Stop', 'Suspend', 'Transfer',
          \ 'Info', 'LimitedCircularFiles', 'LimitedSequentialFiles',
          \ 'SingleFileBoundedSize', 'SingleFileUnboundedSize',
          \ 'UnlimitedSequentialFiles', 'Callstack', 'DateTime',
          \ 'LogicalOperationStack', 'ProcessId', 'ThreadId', 'Timestamp']
  endif

  if len(filter(getline(1, line('$')), "v:val =~# '^\\s*using\\s\\+System\\.Collections;'"))
    syn keyword csBuiltInClasses  ArrayList BitArray CaseInsensitiveComparer
    syn keyword csBuiltInClasses  CaseInsensitiveHashCodeProvider CollectionBase
    syn keyword csBuiltInClasses  Comparer DictionaryBase Hashtable Queue
    syn keyword csBuiltInClasses  ReadOnlyCollectionBase SortedList Stack
    syn keyword csBuiltInClasses  StructuralComparisons
    syn keyword csBuiltInStructs  DictionaryEntry
    syn keyword csBuiltInInterfaces ICollection IComparer IDictionary
    syn keyword csBuiltInInterfaces IDictionaryEnuerator IEnumerable
    syn keyword csBuiltInInterfaces IEnumerator IEqualityComparer
    syn keyword csBuiltInInterfaces IList
    syn keyword csBuiltInInterfaces IStructuralComparable IStructuralEquatable
    " Item is a list
    let l:p = ['Count', 'IsSynchronized', 'SyncRoot', 'IsFixedSize', 'IsReadOnly',
          \ 'Item', 'Keys', 'Values', 'Entry', 'Current', 'Capacity', 'Length',
          \ 'Default', 'DefaultInvariant', 'InnerList', 'List', 'Dictionary',
          \ 'InnerHashtable', 'comparer', 'EqualityComparer', 'hcp',
          \ 'StructuralComparer', 'StructuralEqualityComparer', 'Key', 'Value']
    " IEnumerable
    syn keyword csBuiltInMethods  GetEnumerator
    " ICollection
    syn keyword csBuiltInMethods  CopyTo
    " ICommparer
    syn keyword csBuiltInMethods   Compare
    " IDictionary
    syn keyword csBuiltInMethods  Add Clear Contains
    " IDicrionaryEnumerator
    " IEnumerator
    syn keyword csBuiltInMethods  MoveNext Reset
    " IEqualityComparer
    syn keyword csBuiltInMethods  Equals GetHashCode
    " IHashCodeProvider
    " IList
    syn keyword csBuiltInMethods  IndexOf Insert Remove RemoveAt
    " IStructuralComparable
    syn keyword csBuiltInMethods  CompareTo
    " ArrayList
    syn keyword csBuiltInMethods  Adapter AddRange BinarySearch FixedSize
    syn keyword csBuiltInMethods  GetRange InsertRange LastIndex LastIndexOf
    syn keyword csBuiltInMethods  ReadOnly Reverse Sort Synchronized ToArray
    syn keyword csBuiltInMethods  TrimToSize
    " BitArray
    syn keyword csBuiltInMethods  And Get Not Or Set SetAll Xor
    " CollectionBase
    syn keyword csBuiltInMethods  OnClear OnInsert OnRemove OnSet
    syn keyword csBuiltInMethods  OnSetComplete OnValidate RemoveAt
    " Comparer
    syn keyword csBuiltInFields   Default DefaultInvariant
    " DictrionaryBase
    syn keyword csBuiltInMethods  OnClearComplete OnGet OnInsertComplete
    syn keyword csBuiltInMethods  OnRemoveComplete OnSetComplete
    " Hashtable
    syn keyword csBuiltInMethods  KeyEquals
    " Queue
    syn keyword csBuiltInMethods  Dequeue Enqueue Peek
    " SortedList
    syn keyword csBuiltInMethods  ContainsKey ContainsValue GetByteIndex
    syn keyword csBuiltInMethods  GetKey GetKeyList IndexOfKey IndexOfValue
    syn keyword csBuiltInMethods  SetByIndex
    " Stack
    syn keyword csBuiltInMethods  Pop Push


  endif
    if len(filter(getline(1, line('$')), "v:val =~# '^\\s*using\\s\\+System\\.Runtime\\.Serialization;'"))
      " SerilizedReadOnlyTypes may be a typo
      let l:p = ['IsItemNameSetExplicitly', 'IsKeyNameSetExplicitly',
            \ 'IsNameSetExplicitly', 'IsNamespaceSetExplicitly', 'IsReference',
            \ 'IsReferenceSetExplicitly', 'IsValueNameSetExplicitly', 'ItemName',
            \ 'KeyName', 'Name', 'Namespace', 'ValueName', 'ClrNamespace',
            \ 'ContractNamespace', 'DataContractResolver', 'DataContractSurrogate',
            \ 'IgnoreExtensionDataObject', 'KnownTypes', 'MaxItemsInObjectGraph',
            \ 'PreserveObjectReferences', 'SerializedReadOnlyTypes',
            \ 'DataContractResolver', 'DataContractSurrogate',
            \ 'IgnoreExtensionDataObject', 'RootName', 'RootNamespace',
            \ 'SerializeReadOnlyTypes', 'EmitDefaultValue', 'IsRequired', 'Order',
            \ 'DateTypeStyles', 'FormatProvider', 'FormatString', 'CodeProvider',
            \ 'DataContractSurrogate', 'EnableDatainding', 'GenerateInternal',
            \ 'GenerateSerialzable', 'ImportXmlType', 'Namespaces',
            \ 'ReferencedCollectionTypes', 'ReerencedTypes', 'MethodName', 'Type',
            \ 'Binder', 'Context', 'SurrogateSelector', 'AssemblyFormat',
            \ 'StreamingContext', 'FullTypeName', 'IsAssemblyNameSetExplicit',
            \ 'IsFullTypeNameSetExplicit', 'MemberCount', 'ObjectType', 'Options',
            \ 'Schemas', 'CodeCompileUnit', 'State', 'ExtensionData']
      syn keyword csBuiltInClasses  CollectionDataContractAttribute
      syn keyword csBuiltInClasses  ContractNamespaceAttribute
      syn keyword csBuiltInClasses  DataContractAttribute DataContractResolver
      syn keyword csBuiltInClasses  DataContractSerializer
      syn keyword csBuiltInClasses  DataContractSerializerExtensions
      syn keyword csBuiltInClasses  DataContractSerializerSettings
      syn keyword csBuiltInClasses  DataMemberAttribute DateTimeFormat
      syn keyword csBuiltInClasses  EnumMemberAttribute ExportOptions
      syn keyword csBuiltInClasses  ExtensionDataObject Formatter
      syn keyword csBuiltInClasses  FormatterConverter FormatterServices
      syn keyword csBuiltInClasses  IgnoreDataMemberAttribute ImportOptions
      syn keyword csBuiltInClasses  InvalidDataContractException
      syn keyword csBuiltInClasses  KnownTypeAttribute NetDataContractSerializer
      syn keyword csBuiltInClasses  ObjectIDGenerator ObjectManager
      syn keyword csBuiltInClasses  OnDeserializedAttribute
      syn keyword csBuiltInClasses  OnDeserializingAttribute
      syn keyword csBuiltInClasses  OnSerializedAttribute OnSerializingAttribute
      syn keyword csBuiltInClasses  OptionalFieldAttribute SafeSerializationEventArgs
      syn keyword csBuiltInClasses  SerializationBinder SerializationException
      syn keyword csBuiltInClasses  SerializationInfo SerializationInfoEnumerator
      syn keyword csBuiltInClasses  SerializationObjectManager SurrogateSelector
      syn keyword csBuiltInClasses  XmlObjectSerializer XmlSerializableServices
      syn keyword csBuiltInClasses  XPathQueryGenerator XsdDataContractExporter
      syn keyword csBuiltInClasses  XsdDataContractImporter
      syn keyword csBuiltInStructs  SerializationEntry StreamingContext
      syn keyword csBuiltInInterfaces IDataContractSurrogate
      syn keyword csBuiltInInterfaces IDeserializationCallback IExtensibleDataObject
      syn keyword csBuiltInInterfaces IFormatter IFormatterConverter
      syn keyword csBuiltInInterfaces IObjectReference ISafeSerilzationData
      syn keyword csBuiltInInterfaces ISerializable ISerializationSurrogate
      syn keyword csBuiltInInterfaces ISerializationSurrogateProvider
      syn keyword csBuiltInInterfaces ISurrogateSelector
      syn keyword csBuiltInEnums    EmitTypeInformation StreamContextStates
      let l:e = ['Always', 'AsNeeded', 'Never', 'Clone', 'CrossAppDomain',
            \ 'CrossMachine', 'CrossProcess', 'File', 'Other', 'Persistence',
            \ 'Remoting']
      " DataContractResolver
      syn keyword csBuiltInMethods  ResolveName TryResolveType
      " DataContractSerializer
      " XmlObjectSerializer
      syn keyword csBuiltInMethods  IsStartObject ReadObject WriteEndObject
      syn keyword csBuiltInMethods  WriteObject WriteObjectContent
      syn keyword csBuiltInMethods  WriteStartObject
      " DataContractSerializerExtensions
      syn keyword csBuiltInMethods  GetSerializationSurrogateProvider
      syn keyword csBuiltInMethods  SetSerializationSurrogateProvider
      " DataContractSerializerSettings
      " Formatter
      syn keyword csBuiltInFields   m_idGenerator m_objectQueue
      syn keyword csBuiltInMethods  GetNext Schedule Serialize WriteArray
      syn keyword csBuiltInMethods  WriteBoolean WriteBye WriteChar
      syn keyword csBuiltInMethods  WriteDateTime WriteDecimal WriteDouble
      syn keyword csBuiltInMethods  WriteInt16 WriteIn32 WriteIn64
      syn keyword csBuiltInMethods  WriteMember WriteObjectRef WriteSByte
      syn keyword csBuiltInMethods  WriteSingle WriteTimeSpan WriteUInt16
      syn keyword csBuiltInMethods  WriteUInt32 WriteUInt64 WriteValueType

      " IFormatterConverter
      syn keyword csBuiltInMethods  Convert
      " FormatterServices
      syn keyword csBuiltInMethods  CheckTypeSecurity GetSafeUninitializedObject
      syn keyword csBuiltInMethods  GetSerializableMembers
      syn keyword csBuiltInMethods  GetSurrogateForCyclicalReference
      syn keyword csBuiltInMethods  GetTypeFromAssembly GetUninitializedObject
      syn keyword csBuiltInMethods  PopulateObjectMembers
      " ImportOptions
      " InvalidDataContractException
      " IFormatter
      syn keyword csBuiltInMethods  Deserialize Serialize
      " ObjectIDGenerator
      syn keyword csBuiltInMethods  GetId HasId
      " ObjectManager
      syn keyword csBuiltInMethods  DoFixups RaiseDeserializationEvent
      syn keyword csBuiltInMethods  RaiseOnDeserialzingEvent
      syn keyword csBuiltInMethods  RecordArrayElementFixup
      syn keyword csBuiltInMethods  RecordDelayedFixup RegisterObject
      " SafeSerializationEventArgs
      " SerializationBinder
      syn keyword csBuiltInMethods  BindToName BindToType
      " SerializationInfo
      syn keyword csBuiltInMethods  AddValue GetBoolean GetByte GetChar
      syn keyword csBuiltInMethods  GetDateTime GetDecimal GetDouble
      syn keyword csBuiltInMethods  GetInt16 GetInt32 GetInt64 GetSByte
      syn keyword csBuiltInMethods  GetSingle GetString GetUint16 GetUint32
      syn keyword csBuiltInMethods  GetUInt64 SetType
      " SerializationObjectManager
      syn keyword csBuiltInMethods  RaiseOnSerializedEvent
      " ISurrogateSelector
      syn keyword csBuiltInMethods  ChainSelector GetNextSelector GetSurrogate
      " SurrogateSelector
      syn keyword csBuiltInMethods  AddSurrogate RemoveSurrogate
      " XmlSerializableServices
      syn keyword csBuiltInMethods  AddDefaultSchema ReadNodes WriteNotdes
      " XPathQueryGenerator
      syn keyword csBuiltInMethods  CreateFromDataContractSerializer
      " XsdDataContractExporter
      syn keyword csBuiltInMethods  CanExport Export GetRootElementName
      syn keyword csBuiltInMethods  GetSchemaType GetSchemaTypeName
      " XsdDataContractImporter
      syn keyword csBuiltInMethods  CanImport GetCodeTypeReference
      syn keyword csBuiltInMethods  GetKnownTypeReferences Import
      " IDataContractSurrogate
      syn keyword csBuiltInMethods  GetCustomDataToExport GetDataContractType
      syn keyword csBuiltInMethods  GetDeserializedObject GetKnownCustomDataTypes
      syn keyword csBuiltInMethods  GetObjectToSerialize
      syn keyword csBuiltInMethods  GetReferencedTypeOnImport
      syn keyword csBuiltInMethods  ProcessImportedType
      " IDeserializationCallback
      syn keyword csBuiltInMethods  OnDeserialization
      " IObjectReference
      syn keyword csBuiltInMethods  GetRealObject
      " ISafeSerializationData
      syn keyword csBuiltInMethods  CompleteDeserialization
      " ISerializationSurrogate
      syn keyword csBuiltInMethods  SetObjectData
      " ISerializationSurrogateProvider
      syn keyword csBuiltInMethods  GetSurrogateType


    endif
" Obsolete
"IHashCodeProvider, CaseInsensitiveHashCodeProvider
endfunction
hi def link csBuiltInClasses    class
hi def link csBuiltInEnums      enumName
hi def link csBuiltInEnumValues enumValue
hi def link csBuiltInEvents     event
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
