import Workspaces, { ClientTitle } from "Hypr/Workspaces";
import BatteryLabel from "Common/Battery";
import TimeWidget from "Common/Time";
import SysTray from "./SysTray";
const notifications = await Service.import("notifications");

const BarWidgets = {
  Left: () =>
    Widget.Box({
      class_name: 'left_bar',
      hpack: 'start',
      children: [
        ClientTitle(),
      ],
    }),
  Centre: () =>
    Widget.Box({
      class_name: 'centre_bar',
      hpack: 'center',
      children: [
        Workspaces(),
      ],
    }),
  Right: () =>
    Widget.Box({
      class_name: 'right_bar',
      hpack: 'end',
      children: [
        BatteryLabel(),
        SysTray(),
        TimeWidget({}),
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
