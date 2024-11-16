import { App, Astal, Gtk, Gdk } from "astal/gtk3";
import { Variable } from "astal";
import Tray from "gi://AstalTray";
import SysTray from "./SysTray";

export default function Bar(gdkmonitor: Gdk.Monitor) {
  const time = Variable("").poll(1000, "date");
  return (
    <window
      className="Bar"
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={
        Astal.WindowAnchor.TOP |
        Astal.WindowAnchor.LEFT |
        Astal.WindowAnchor.RIGHT
      }
      application={App}
    >
      <centerbox>
        <box />
        <SysTray />
        <box />
      </centerbox>
    </window>
  );
}
