import Tray from "gi://AstalTray";
import { App, Astal, Gtk, Gdk } from "astal/gtk3";
import { Variable } from "astal";
import { bind } from "astal";
import { type Binding } from "astal";
import Battery from "gi://AstalBattery";
const tray = Tray.get_default();

export default function SysTray() {
  const bat = Battery.get_default();

  return <label label={bind(bat, "percentage").as((p) => p * 100 + " %")} />;
}
