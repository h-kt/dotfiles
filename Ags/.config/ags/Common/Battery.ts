const battery = await Service.import("battery");

const BatteryLabel = () => {
  const value = battery.bind("percent").as((p) => (p > 0 ? p / 100 : 0));
  const icon = battery
    .bind("percent")
    .as((p) => `battery-level-${Math.floor(p / 10) * 10}-symbolic`);
  const label = battery.bind("percent").as((p) => p.toString() + '%');
  const charging = battery.bind("charging").as((charging) => charging ? `` : '');

  return Widget.Box({
    class_name: "battery",
    visible: battery.bind("available"),
    children: [
      Widget.Label({ label, css: 'margin: 0px 3px;' }),
      Widget.Icon({ icon }),
      Widget.Label({ label: charging, css: 'margin: 0px 3px;' }),
      // Widget.LevelBar({
      //   widthRequest: 20,
      //   vpack: "center",
      //   value,
      // }),
    ],
  });
};

export default BatteryLabel;
