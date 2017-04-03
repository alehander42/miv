import jsffi, strutils, sequtils, future
import electron_nim

let electron = require("electron")

var mainWindow: electron.BrowserWindow
var app: ElectronApp = electron.app

proc onClosed() =
  mainWindow = nil

proc createMainWindow(): BrowserWindow =
  let win = BrowserWindow(width: 400, height: 400)
  # let dirname = os.getCurrentDir()
  let dirname = "some hardcoded name"
  win.loadURL("file://" & dirname & "/index.html")
  win.on(evClosed, onClosed)
  return win

app.on(evWindowAllClosed, proc() =
  if process.platform != "darwin":
    app.quit())

app.on(evActivate, proc() =
  if mainWindow == nil:
    mainWindow = createMainWindow())

app.on(evReady, proc() =
  mainWindow = createMainWindow())






