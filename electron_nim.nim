import macros, dom, jsffi, typetraits

when not defined(js):
  {.error "Electron is only available for javascript"}

type
  ElectronGlobal* {.importc.} = ref object of RootObj
    version*: cstring

  EventTarget* = ref object
    value*: cstring

  Event* = ref object
    target*: EventTarget
    `type`: cstring

  ElectronApp* {.importc.} = ref object of RootObj
    on*: proc(event: EventName, f: proc(): void): void
    quit*: proc(): void
  
  ElectronProcess* {.importc.} = ref object of RootObj
    platform*: cstring

  Electron* = ref object of RootObj
    app*: ElectronApp
    BrowserWindow*: BrowserWindow

  EventName* = enum evWindowAllClosed, evReady, evActivate, evClosed
  
  Attrs* = ref object
    onClick*, onChange*: proc(e: Event)
    `ref`*: cstring
    width*, height*: cint

  BrowserWindow* {.importcpp.} = ref object of RootObj
    loadURL*: proc(url: cstring): void
    on*: proc(event: EventName, f: proc(): void): void

    width*, height*, x*, y*: cint

    useContentSize*, center*, resizable*, focusable*, thickFrame*: bool

    parent*: ref BrowserWindow

    backgroundColor*: string

var
  process* {.importcpp, nodecl.}: ElectronProcess
  require* {.importc, nodecl.}: proc (l: cstring): Electron
