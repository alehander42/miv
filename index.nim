import jsffi, strutils, sequtils, future
import electron_nim

let electron = require("electron")

var mainWindow: JsObject
var app = electron.app

proc onClosed() =
  mainWindow = nil

proc js[K, V](fields: openarray[(K, V)]): JsObject =
  result = newJsObject()
  for i, pair in fields:
    result[pair[0]] = pair[1]

proc jsnew*(x: auto): JsObject {. importcpp: "(new #)" .}

proc createMainWindow(): JsObject =
  let win = jsnew electron.BrowserWindow({ "width": 400, "height": 400 }.js)
  # let dirname = os.getCurrentDir()
  let url = "file://" & currentSourcePath.replace(".nim", ".html")
  discard win.loadURL(cstring(url))
  discard win.on("closed", onClosed)
  return win

proc windowClosed =
  if process.platform != "darwin":
    discard app.quit()

proc windowActivated =
  if mainWindow == nil:
    mainWindow = createMainWindow()

proc appReady =
  mainWindow = createMainWindow()

discard app.on(cstring("window-all-closed"), windowClosed)
discard app.on(cstring("activate"), windowActivated)
discard app.on(cstring("ready"), appReady)

