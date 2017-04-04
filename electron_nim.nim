import macros, dom, jsffi, typetraits

when not defined(js):
  {.error "Electron is only available for javascript"}

type
  ElectronGlobal* {.importc.} = ref object of JsObject
    version*: cstring

  EventTarget* = ref object
    value*: cstring

  Event* = ref object
    target*: EventTarget
    `type`: cstring

  ElectronApp* {.importc.} = ref object of JsObject
    quit*: proc(): void
  
  ElectronProcess* {.importc.} = ref object of JsObject
    platform*: cstring

  Electron* = ref object of JsObject
    app*: ElectronApp
    BrowserWindow*: BrowserWindow

  Attrs* = ref object
    onClick*, onChange*: proc(e: Event)
    `ref`*: cstring
    width*, height*: cint

  BrowserWindow* {.importcpp.} = ref object of JsObject
    loadURL*: proc(url: cstring): void

    width*, height*, x*, y*: cint

    useContentSize*, center*, resizable*, focusable*, thickFrame*: bool

    parent*: ref BrowserWindow

    backgroundColor*: cstring

var
  process* {.importcpp, nodecl.}: ElectronProcess
  require* {.importc, nodecl.}: proc (module: cstring): JsObject

