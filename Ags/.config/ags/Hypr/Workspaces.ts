const hyprland = await Service.import("hyprland");

enum Numbers {
  〇 = 0,
  壹 = 1,
  貳 = 2,
  叁 = 3,
  肆 = 4,
  伍 = 5,
  陸 = 6,
  柒 = 7,
  捌 = 8,
  玖 = 9,
  拾 = 10,
}

const getWorkspaceName = (i: number) => Numbers[i];

export const ClientTitle = () =>
  Widget.Label({
    class_name: "client-title",
    label: hyprland.active.client.bind("title").as((t) => `👉 ${t}`),
    truncate: "end",
    maxWidthChars: 200,
    justification: "left",
  });

const Workspaces = () => {
  const activeId = hyprland.active.workspace.bind("id");
  const workspaces = hyprland.bind("workspaces").as((ws) =>
    ws
      .sort((a, b) => a.id - b.id)
      .map(({ id }) =>
        Widget.Button({
          on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
          child: Widget.Label(`${getWorkspaceName(id) ?? "〇"}`),
          class_name: activeId.as((i) => `${i === id ? "focused" : ""}`),
          cursor: "pointer",
        }),
      ),
  );

  return Widget.Box({
    class_name: "workspaces",
    children: workspaces,
    cursor: "pointer",
  });
};

export default Workspaces;
