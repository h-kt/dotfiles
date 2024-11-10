import Workspaces, { ClientTitle } from "Hypr/Workspaces";
import BatteryLabel from "Common/Battery";
import TimeWidget from "Common/Time";
import Volume from "Common/Audio";
import Media from "Common/Media";
import SysTray from "./SysTray";
const notifications = await Service.import("notifications");

const Notification = () => {
  const popups = notifications.bind("popups");
  return Widget.Box({
    class_name: "notification",
    visible: popups.as((p) => p.length > 0),
    children: [
      Widget.Icon({
        icon: "preferences-system-notifications-symbolic",
      }),
      Widget.Label({
        label: popups.as((p) => p[0]?.summary || ""),
      }),
    ],
  });
};

const BarWidgets = {
  Left: () =>
    Widget.Box({
      children: [Workspaces(), ClientTitle(), Media()],
    }),
  Centre: () =>
    Widget.Box({
      children: [],
    }),
  Right: () =>
    Widget.Box({
      children: [
        Volume(),
        BatteryLabel(),
        SysTray(),
        TimeWidget({}),
        Notification(),
      ],
    }),
};

const Bar = (monitor: number = 0) => {
  return Widget.Window({
    name: `bar-${monitor}`,
    class_name: "bar",
    monitor,
    anchor: ["top", "left", "right"],
    exclusivity: "exclusive",
    child: Widget.CenterBox({
      start_widget: BarWidgets.Left(),
      center_widget: BarWidgets.Centre(),
      end_widget: BarWidgets.Right(),
    }),
  });
};

export default Bar;
