local Players = game:GetService("Players");
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");

local G2L = {};
local targetParent = (gethui and gethui()) or game:GetService("CoreGui") or PlayerGui;

-- Löscht eine bereits existierende UI, um Duplikate zu vermeiden
if targetParent:FindFirstChild("GoonHub") then
	targetParent:FindFirstChild("GoonHub"):Destroy()
end

-- StarterGui.GoonHub
G2L["1"] = Instance.new("ScreenGui");
G2L["1"]["IgnoreGuiInset"] = true;
G2L["1"]["DisplayOrder"] = 9999998;
G2L["1"]["ScreenInsets"] = Enum.ScreenInsets.DeviceSafeInsets;
G2L["1"]["Name"] = [[GoonHub]];
G2L["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;
G2L["1"]["ResetOnSpawn"] = false;
G2L["1"]["Parent"] = targetParent;


-- StarterGui.GoonHub.Main
G2L["2"] = Instance.new("CanvasGroup", G2L["1"]);
G2L["2"]["BorderSizePixel"] = 0;
G2L["2"]["BackgroundColor3"] = Color3.fromRGB(36, 36, 36);
G2L["2"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["2"]["Size"] = UDim2.new(0, 700, 0, 465);
G2L["2"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["2"]["Name"] = [[Main]];


-- StarterGui.GoonHub.Main.Scale
G2L["3"] = Instance.new("UIScale", G2L["2"]);
G2L["3"]["Name"] = [[Scale]];


-- StarterGui.GoonHub.Main.panel
G2L["4"] = Instance.new("Frame", G2L["2"]);
G2L["4"]["BorderSizePixel"] = 0;
G2L["4"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["4"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["4"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["4"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["4"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["4"]["Name"] = [[panel]];
G2L["4"]["BackgroundTransparency"] = 1;


-- StarterGui.GoonHub.Main.panel.controls
G2L["5"] = Instance.new("Frame", G2L["4"]);
G2L["5"]["ZIndex"] = 999;
G2L["5"]["BorderSizePixel"] = 0;
G2L["5"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["5"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["5"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["5"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["5"]["Name"] = [[controls]];
G2L["5"]["LayoutOrder"] = 99;
G2L["5"]["BackgroundTransparency"] = 1;
G2L["5"]["Active"] = false;


-- StarterGui.GoonHub.Main.panel.controls.drag
G2L["6"] = Instance.new("ImageButton", G2L["5"]);
G2L["6"]["BorderSizePixel"] = 0;
G2L["6"]["ImageTransparency"] = 1;
G2L["6"]["BackgroundTransparency"] = 1;
G2L["6"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["6"]["AnchorPoint"] = Vector2.new(0.5, 0);
G2L["6"]["Image"] = [[rbxasset://textures/ui/GuiImagePlaceholder.png]];
G2L["6"]["Size"] = UDim2.new(0, 70, 0, 35);
G2L["6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["6"]["Name"] = [[drag]];
G2L["6"]["Position"] = UDim2.new(0.5, 0, 0, 0);


-- StarterGui.GoonHub.Main.panel.controls.drag.bar
G2L["7"] = Instance.new("Frame", G2L["6"]);
G2L["7"]["BorderSizePixel"] = 0;
G2L["7"]["BackgroundColor3"] = Color3.fromRGB(91, 91, 91);
G2L["7"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["7"]["Size"] = UDim2.new(1, 0, 0, 5);
G2L["7"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["7"]["Name"] = [[bar]];
G2L["7"]["BackgroundTransparency"] = 0.5;

-- StarterGui.GoonHub.Main.panel.controls.drag.bar.Corner
G2L["8"] = Instance.new("UICorner", G2L["7"]);
G2L["8"]["Name"] = [[Corner]];
G2L["8"]["CornerRadius"] = UDim.new(1, 0);


-- StarterGui.GoonHub.Main.panel.controls.drag.bar.stroke
G2L["9"] = Instance.new("UIStroke", G2L["7"]);
G2L["9"]["Enabled"] = false;
G2L["9"]["Color"] = Color3.fromRGB(255, 255, 255);
G2L["9"]["Name"] = [[stroke]];


-- StarterGui.GoonHub.Main.panel.controls.drag.padding
G2L["a"] = Instance.new("UIPadding", G2L["6"]);
G2L["a"]["PaddingRight"] = UDim.new(0, 15);
G2L["a"]["Name"] = [[padding]];
G2L["a"]["PaddingLeft"] = UDim.new(0, 15);


-- StarterGui.GoonHub.Main.panel.controls.resize
G2L["b"] = Instance.new("ImageButton", G2L["5"]);
G2L["b"]["BorderSizePixel"] = 0;
G2L["b"]["AutoButtonColor"] = false;
G2L["b"]["BackgroundTransparency"] = 1;
G2L["b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["b"]["AnchorPoint"] = Vector2.new(1, 1);
G2L["b"]["Size"] = UDim2.new(0, 35, 0, 35);
G2L["b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["b"]["Name"] = [[resize]];
G2L["b"]["Position"] = UDim2.new(1, -8, 1, -8);


-- StarterGui.GoonHub.Main.panel.controls.resize.icon
G2L["c"] = Instance.new("ImageLabel", G2L["b"]);
G2L["c"]["BorderSizePixel"] = 0;
G2L["c"]["SliceCenter"] = Rect.new(132, 132, 224, 224);
G2L["c"]["SliceScale"] = 0.03;
G2L["c"]["ScaleType"] = Enum.ScaleType.Slice;
G2L["c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["c"]["ImageColor3"] = Color3.fromRGB(91, 91, 91);
G2L["c"]["AnchorPoint"] = Vector2.new(1, 1);
G2L["c"]["Image"] = [[rbxassetid://88780680171023]];
G2L["c"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["c"]["BackgroundTransparency"] = 1;
G2L["c"]["Name"] = [[icon]];
G2L["c"]["Position"] = UDim2.new(1, 0, 1, 0);


-- StarterGui.GoonHub.Main.panel.controls.resize.icon.scale
G2L["d"] = Instance.new("UIScale", G2L["c"]);
G2L["d"]["Name"] = [[scale]];


-- StarterGui.GoonHub.Main.panel.controls.resize.Padding
G2L["e"] = Instance.new("UIPadding", G2L["b"]);
G2L["e"]["PaddingTop"] = UDim.new(0, 10);
G2L["e"]["Name"] = [[Padding]];
G2L["e"]["PaddingLeft"] = UDim.new(0, 10);


-- StarterGui.GoonHub.Main.panel.controls.resize.Scale
G2L["f"] = Instance.new("UIScale", G2L["b"]);
G2L["f"]["Name"] = [[Scale]];


-- StarterGui.GoonHub.Main.panel.content
G2L["10"] = Instance.new("Frame", G2L["4"]);
G2L["10"]["BorderSizePixel"] = 0;
G2L["10"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["10"]["AnchorPoint"] = Vector2.new(0.5, 1);

G2L["10"]["Size"] = UDim2.new(1, 0, 1, -35);
G2L["10"]["Position"] = UDim2.new(0.5, 0, 1, 0);
G2L["10"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["10"]["Name"] = [[content]];
G2L["10"]["BackgroundTransparency"] = 1;


-- StarterGui.GoonHub.Main.panel.content.screen
G2L["11"] = Instance.new("Frame", G2L["10"]);
G2L["11"]["BorderSizePixel"] = 0;
G2L["11"]["BackgroundColor3"] = Color3.fromRGB(21, 21, 21);
G2L["11"]["AnchorPoint"] = Vector2.new(1, 1);
G2L["11"]["ClipsDescendants"] = true;
G2L["11"]["Size"] = UDim2.new(1, -235, 1, 0);
G2L["11"]["Position"] = UDim2.new(1.01606, -14, 1.10864, -14);
G2L["11"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["11"]["Name"] = [[screen]];
G2L["11"]["LayoutOrder"] = 10;
G2L["11"]["BackgroundTransparency"] = 0.7;


-- StarterGui.GoonHub.Main.panel.content.screen.Padding
G2L["12"] = Instance.new("UIPadding", G2L["11"]);
G2L["12"]["Name"] = [[Padding]];


-- StarterGui.GoonHub.Main.panel.content.screen.corner
G2L["13"] = Instance.new("UICorner", G2L["11"]);
G2L["13"]["Name"] = [[corner]];
G2L["13"]["CornerRadius"] = UDim.new(0, 12);


-- StarterGui.GoonHub.Main.panel.content.screen.Page
G2L["14"] = Instance.new("UIPageLayout", G2L["11"]);
G2L["14"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Right;
G2L["14"]["EasingStyle"] = Enum.EasingStyle.Linear;
G2L["14"]["GamepadInputEnabled"] = false;
G2L["14"]["EasingDirection"] = Enum.EasingDirection.InOut;
G2L["14"]["TouchInputEnabled"] = false;
G2L["14"]["Animated"] = false;
G2L["14"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
G2L["14"]["Name"] = [[Page]];
G2L["14"]["ScrollWheelInputEnabled"] = false;


-- StarterGui.GoonHub.Main.panel.content.screen.Flex
G2L["15"] = Instance.new("UIFlexItem", G2L["11"]);
G2L["15"]["Name"] = [[Flex]];
G2L["15"]["FlexMode"] = Enum.UIFlexMode.Fill;


-- StarterGui.GoonHub.Main.panel.content.bar
G2L["16"] = Instance.new("ImageButton", G2L["10"]);
G2L["16"]["BorderSizePixel"] = 0;
G2L["16"]["AutoButtonColor"] = false;
G2L["16"]["BackgroundTransparency"] = 1;
G2L["16"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["16"]["AnchorPoint"] = Vector2.new(0, 1);
G2L["16"]["Size"] = UDim2.new(0, 220, 1, 0);
G2L["16"]["ClipsDescendants"] = true;
G2L["16"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["16"]["Name"] = [[bar]];
G2L["16"]["Position"] = UDim2.new(0, 0, 1, 0);
G2L["16"]["Active"] = false;
G2L["16"]["Selectable"] = false;


-- StarterGui.GoonHub.Main.panel.content.bar.Layout
G2L["17"] = Instance.new("UIListLayout", G2L["16"]);
G2L["17"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
G2L["17"]["Padding"] = UDim.new(0, 7);
G2L["17"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
G2L["17"]["Name"] = [[Layout]];


-- StarterGui.GoonHub.Main.panel.content.bar.anchored_buttons
G2L["18"] = Instance.new("Frame", G2L["16"]);
G2L["18"]["BorderSizePixel"] = 0;
G2L["18"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["18"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["18"]["AutomaticSize"] = Enum.AutomaticSize.Y;
G2L["18"]["Size"] = UDim2.new(1, 0, 0, 0);
G2L["18"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["18"]["Name"] = [[anchored_buttons]];
G2L["18"]["LayoutOrder"] = 5;
G2L["18"]["BackgroundTransparency"] = 1;


-- StarterGui.GoonHub.Main.panel.content.bar.anchored_buttons.main
G2L["19"] = Instance.new("Frame", G2L["18"]);
G2L["19"]["BorderSizePixel"] = 0;
G2L["19"]["BackgroundColor3"] = Color3.fromRGB(9, 9, 9);
G2L["19"]["AutomaticSize"] = Enum.AutomaticSize.Y;
G2L["19"]["Size"] = UDim2.new(1, 0, 0, 0);
G2L["19"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["19"]["Name"] = [[main]];
G2L["19"]["BackgroundTransparency"] = 0.7;


-- StarterGui.GoonHub.Main.panel.content.bar.anchored_buttons.main.list
G2L["1a"] = Instance.new("UIListLayout", G2L["19"]);
G2L["1a"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
G2L["1a"]["Padding"] = UDim.new(0, 5);
G2L["1a"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
G2L["1a"]["Name"] = [[list]];


-- StarterGui.GoonHub.Main.panel.content.bar.anchored_buttons.main.flex
G2L["1b"] = Instance.new("UIFlexItem", G2L["19"]);
G2L["1b"]["Name"] = [[flex]];
G2L["1b"]["FlexMode"] = Enum.UIFlexMode.Fill;


-- StarterGui.GoonHub.Main.panel.content.bar.anchored_buttons.main.Corner
G2L["1c"] = Instance.new("UICorner", G2L["19"]);
G2L["1c"]["Name"] = [[Corner]];
G2L["1c"]["CornerRadius"] = UDim.new(0, 12);


-- StarterGui.GoonHub.Main.panel.content.bar.anchored_buttons.main.padding
G2L["1d"] = Instance.new("UIPadding", G2L["19"]);
G2L["1d"]["PaddingTop"] = UDim.new(0, 7);
G2L["1d"]["PaddingRight"] = UDim.new(0, 6);
G2L["1d"]["Name"] = [[padding]];
G2L["1d"]["PaddingLeft"] = UDim.new(0, 6);
G2L["1d"]["PaddingBottom"] = UDim.new(0, 7);


-- StarterGui.GoonHub.Main.panel.content.bar.anchored_buttons.main.settings
G2L["1e"] = Instance.new("ImageButton", G2L["19"]);
G2L["1e"]["SliceScale"] = 0.01;
G2L["1e"]["BorderSizePixel"] = 0;
G2L["1e"]["SliceCenter"] = Rect.new(512, 512, 512, 512);
G2L["1e"]["ScaleType"] = Enum.ScaleType.Slice;
G2L["1e"]["AutoButtonColor"] = false;
G2L["1e"]["ImageTransparency"] = 1;
G2L["1e"]["BackgroundTransparency"] = 1;
G2L["1e"]["BackgroundColor3"] = Color3.fromRGB(41, 41, 41);
G2L["1e"]["ImageColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1e"]["Image"] = [[rbxassetid://125088425775676]];
G2L["1e"]["Size"] = UDim2.new(1, 0, 0, 30);
G2L["1e"]["LayoutOrder"] = 1;
G2L["1e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1e"]["Name"] = [[settings]];

-- StarterGui.GoonHub.Main.panel.content.bar.anchored_buttons.main.settings.list
G2L["1f"] = Instance.new("UIListLayout", G2L["1e"]);
G2L["1f"]["Padding"] = UDim.new(0, 10);
G2L["1f"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
G2L["1f"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
G2L["1f"]["Name"] = [[list]];
G2L["1f"]["FillDirection"] = Enum.FillDirection.Horizontal;


-- StarterGui.GoonHub.Main.panel.content.bar.anchored_buttons.main.settings.padding
G2L["20"] = Instance.new("UIPadding", G2L["1e"]);
G2L["20"]["PaddingRight"] = UDim.new(0, 12);
G2L["20"]["Name"] = [[padding]];
G2L["20"]["PaddingLeft"] = UDim.new(0, 12);


-- StarterGui.GoonHub.Main.panel.content.bar.anchored_buttons.main.settings.label
G2L["21"] = Instance.new("TextLabel", G2L["1e"]);
G2L["21"]["BorderSizePixel"] = 0;
G2L["21"]["AutoLocalize"] = false;
G2L["21"]["TextSize"] = 14;
G2L["21"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["21"]["TextTransparency"] = 0.5;
G2L["21"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["21"]["FontFace"] = Font.new([[rbxassetid://12187365364]], Enum.FontWeight.Medium, Enum.FontStyle.Normal);
G2L["21"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["21"]["BackgroundTransparency"] = 1;
G2L["21"]["Size"] = UDim2.new(0, 0, 0, 22);
G2L["21"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["21"]["Text"] = [[Settings]];
G2L["21"]["LayoutOrder"] = 2;
G2L["21"]["Name"] = [[label]];
G2L["21"]["Position"] = UDim2.new(0.16667, 0, 0, 0);

-- StarterGui.GoonHub.Main.panel.content.bar.anchored_buttons.main.settings.label.Flex
G2L["22"] = Instance.new("UIFlexItem", G2L["21"]);
G2L["22"]["Name"] = [[Flex]];
G2L["22"]["FlexMode"] = Enum.UIFlexMode.Fill;


-- StarterGui.GoonHub.Main.panel.content.bar.anchored_buttons.main.settings.corner
G2L["23"] = Instance.new("UICorner", G2L["1e"]);
G2L["23"]["Name"] = [[corner]];
G2L["23"]["CornerRadius"] = UDim.new(0, 12);


-- StarterGui.GoonHub.Main.panel.content.bar.anchored_buttons.main.settings.holder
G2L["24"] = Instance.new("ImageLabel", G2L["1e"]);
G2L["24"]["BorderSizePixel"] = 0;
G2L["24"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["24"]["ImageTransparency"] = 1;
G2L["24"]["Size"] = UDim2.new(0, 20, 0, 20);
G2L["24"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["24"]["BackgroundTransparency"] = 0.8;
G2L["24"]["LayoutOrder"] = 1;
G2L["24"]["Name"] = [[holder]];


-- StarterGui.GoonHub.Main.panel.content.bar.anchored_buttons.main.settings.holder.icon
G2L["25"] = Instance.new("ImageLabel", G2L["24"]);
G2L["25"]["BorderSizePixel"] = 0;
G2L["25"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["25"]["ImageTransparency"] = 0.5;
G2L["25"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["25"]["Image"] = [[rbxassetid://11293977610]];
G2L["25"]["Size"] = UDim2.new(0, 14, 0, 14);
G2L["25"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["25"]["BackgroundTransparency"] = 1;
G2L["25"]["LayoutOrder"] = 1;
G2L["25"]["Name"] = [[icon]];
G2L["25"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.GoonHub.Main.panel.content.bar.anchored_buttons.main.settings.holder.Corner
G2L["26"] = Instance.new("UICorner", G2L["24"]);
G2L["26"]["Name"] = [[Corner]];
G2L["26"]["CornerRadius"] = UDim.new(0, 6);


-- StarterGui.GoonHub.Main.panel.content.bar.anchored_buttons.main.settings.icons
G2L["27"] = Instance.new("Frame", G2L["1e"]);
G2L["27"]["BorderSizePixel"] = 0;
G2L["27"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["27"]["Size"] = UDim2.new(0, 0, 0, 22);
G2L["27"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["27"]["Name"] = [[icons]];
G2L["27"]["LayoutOrder"] = 9;


-- StarterGui.GoonHub.Main.panel.content.bar.anchored_buttons.main.settings.icons.list
G2L["28"] = Instance.new("UIListLayout", G2L["27"]);
G2L["28"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Right;
G2L["28"]["Padding"] = UDim.new(0, 10);
G2L["28"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
G2L["28"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
G2L["28"]["Name"] = [[list]];
G2L["28"]["FillDirection"] = Enum.FillDirection.Horizontal;


-- StarterGui.GoonHub.Main.panel.content.bar.anchored_buttons.main.about
G2L["29"] = Instance.new("ImageButton", G2L["19"]);
G2L["29"]["SliceScale"] = 0.01;
G2L["29"]["BorderSizePixel"] = 0;
G2L["29"]["SliceCenter"] = Rect.new(512, 512, 512, 512);
G2L["29"]["ScaleType"] = Enum.ScaleType.Slice;
G2L["29"]["AutoButtonColor"] = false;
G2L["29"]["ImageTransparency"] = 1;
G2L["29"]["BackgroundTransparency"] = 1;
G2L["29"]["BackgroundColor3"] = Color3.fromRGB(41, 41, 41);
G2L["29"]["ImageColor3"] = Color3.fromRGB(0, 0, 0);
G2L["29"]["Image"] = [[rbxassetid://125088425775676]];
G2L["29"]["Size"] = UDim2.new(1, 0, 0, 30);
G2L["29"]["LayoutOrder"] = 2;
G2L["29"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["29"]["Name"] = [[about]];

-- StarterGui.GoonHub.Main.panel.content.bar.anchored_buttons.main.about.list
G2L["2a"] = Instance.new("UIListLayout", G2L["29"]);
G2L["2a"]["Padding"] = UDim.new(0, 10);
G2L["2a"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
G2L["2a"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
G2L["2a"]["Name"] = [[list]];
G2L["2a"]["FillDirection"] = Enum.FillDirection.Horizontal;


-- StarterGui.GoonHub.Main.panel.content.bar.anchored_buttons.main.about.padding
G2L["2b"] = Instance.new("UIPadding", G2L["29"]);
G2L["2b"]["PaddingRight"] = UDim.new(0, 12);
G2L["2b"]["Name"] = [[padding]];
G2L["2b"]["PaddingLeft"] = UDim.new(0, 12);


-- StarterGui.GoonHub.Main.panel.content.bar.anchored_buttons.main.about.label
G2L["2c"] = Instance.new("TextLabel", G2L["29"]);
G2L["2c"]["BorderSizePixel"] = 0;
G2L["2c"]["AutoLocalize"] = false;
G2L["2c"]["TextSize"] = 14;
G2L["2c"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["2c"]["TextTransparency"] = 0.5;
G2L["2c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["2c"]["FontFace"] = Font.new([[rbxassetid://12187365364]], Enum.FontWeight.Medium, Enum.FontStyle.Normal);
G2L["2c"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["2c"]["BackgroundTransparency"] = 1;
G2L["2c"]["Size"] = UDim2.new(0, 0, 0, 22);
G2L["2c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["2c"]["Text"] = [[About]];
G2L["2c"]["LayoutOrder"] = 2;
G2L["2c"]["Name"] = [[label]];
G2L["2c"]["Position"] = UDim2.new(0.16667, 0, 0, 0);

-- StarterGui.GoonHub.Main.panel.content.bar.anchored_buttons.main.about.label.Flex
G2L["2d"] = Instance.new("UIFlexItem", G2L["2c"]);
G2L["2d"]["Name"] = [[Flex]];
G2L["2d"]["FlexMode"] = Enum.UIFlexMode.Fill;


-- StarterGui.GoonHub.Main.panel.content.bar.anchored_buttons.main.about.corner
G2L["2e"] = Instance.new("UICorner", G2L["29"]);
G2L["2e"]["Name"] = [[corner]];
G2L["2e"]["CornerRadius"] = UDim.new(0, 12);


-- StarterGui.GoonHub.Main.panel.content.bar.anchored_buttons.main.about.holder
G2L["2f"] = Instance.new("ImageLabel", G2L["29"]);
G2L["2f"]["BorderSizePixel"] = 0;
G2L["2f"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["2f"]["ImageTransparency"] = 1;
G2L["2f"]["Size"] = UDim2.new(0, 20, 0, 20);
G2L["2f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["2f"]["BackgroundTransparency"] = 0.8;
G2L["2f"]["LayoutOrder"] = 1;
G2L["2f"]["Name"] = [[holder]];


-- StarterGui.GoonHub.Main.panel.content.bar.anchored_buttons.main.about.holder.icon
G2L["30"] = Instance.new("ImageLabel", G2L["2f"]);
G2L["30"]["BorderSizePixel"] = 0;
G2L["30"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["30"]["ImageTransparency"] = 0.5;
G2L["30"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["30"]["Image"] = [[rbxassetid://11419720347]];
G2L["30"]["Size"] = UDim2.new(0, 14, 0, 14);
G2L["30"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["30"]["BackgroundTransparency"] = 1;
G2L["30"]["LayoutOrder"] = 1;
G2L["30"]["Name"] = [[icon]];
G2L["30"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.GoonHub.Main.panel.content.bar.anchored_buttons.main.about.holder.Corner
G2L["31"] = Instance.new("UICorner", G2L["2f"]);
G2L["31"]["Name"] = [[Corner]];
G2L["31"]["CornerRadius"] = UDim.new(0, 6);


-- StarterGui.GoonHub.Main.panel.content.bar.anchored_buttons.main.about.icons
G2L["32"] = Instance.new("Frame", G2L["29"]);
G2L["32"]["BorderSizePixel"] = 0;
G2L["32"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["32"]["Size"] = UDim2.new(0, 0, 0, 22);
G2L["32"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["32"]["Name"] = [[icons]];
G2L["32"]["LayoutOrder"] = 9;


-- StarterGui.GoonHub.Main.panel.content.bar.anchored_buttons.main.about.icons.list
G2L["33"] = Instance.new("UIListLayout", G2L["32"]);
G2L["33"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Right;
G2L["33"]["Padding"] = UDim.new(0, 10);
G2L["33"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
G2L["33"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
G2L["33"]["Name"] = [[list]];
G2L["33"]["FillDirection"] = Enum.FillDirection.Horizontal;


-- StarterGui.GoonHub.Main.panel.content.bar.anchored_buttons.main.about.icons.warning
G2L["34"] = Instance.new("ImageLabel", G2L["32"]);
G2L["34"]["BorderSizePixel"] = 0;
G2L["34"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["34"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["34"]["ImageTransparency"] = 0.5;
G2L["34"]["ImageColor3"] = Color3.fromRGB(255, 192, 0);
G2L["34"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["34"]["Image"] = [[rbxassetid://11419713314]];
G2L["34"]["Size"] = UDim2.new(0, 16, 0, 16);
G2L["34"]["Visible"] = false;
G2L["34"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["34"]["BackgroundTransparency"] = 1;
G2L["34"]["Name"] = [[warning]];
G2L["34"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.GoonHub.Main.panel.content.bar.anchored_buttons.main.about.icons.loading
G2L["35"] = Instance.new("ImageLabel", G2L["32"]);
G2L["35"]["BorderSizePixel"] = 0;
G2L["35"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["35"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["35"]["ImageTransparency"] = 0.5;
G2L["35"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["35"]["Image"] = [[rbxassetid://11963357970]];
G2L["35"]["Size"] = UDim2.new(0, 16, 0, 16);
G2L["35"]["Visible"] = false;
G2L["35"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["35"]["BackgroundTransparency"] = 1;
G2L["35"]["Name"] = [[loading]];
G2L["35"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.GoonHub.Main.panel.content.bar.anchored_buttons.list
G2L["36"] = Instance.new("UIListLayout", G2L["18"]);
G2L["36"]["Padding"] = UDim.new(0, 10);
G2L["36"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
G2L["36"]["Name"] = [[list]];


-- StarterGui.GoonHub.Main.panel.content.bar.anchored_buttons.padding
G2L["37"] = Instance.new("UIPadding", G2L["18"]);
G2L["37"]["PaddingRight"] = UDim.new(0, 13);
G2L["37"]["Name"] = [[padding]];
G2L["37"]["PaddingLeft"] = UDim.new(0, 13);


-- StarterGui.GoonHub.Main.panel.content.bar.user
G2L["38"] = Instance.new("ImageButton", G2L["16"]);
G2L["38"]["BorderSizePixel"] = 0;
G2L["38"]["AutoButtonColor"] = false;
G2L["38"]["ImageTransparency"] = 1;
G2L["38"]["BackgroundTransparency"] = 0.7;
G2L["38"]["BackgroundColor3"] = Color3.fromRGB(9, 9, 9);
G2L["38"]["Size"] = UDim2.new(1, -22, 0, 48);
G2L["38"]["LayoutOrder"] = 10;
G2L["38"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["38"]["Name"] = [[user]];


-- StarterGui.GoonHub.Main.panel.content.bar.user.Corner
G2L["39"] = Instance.new("UICorner", G2L["38"]);
G2L["39"]["Name"] = [[Corner]];
G2L["39"]["CornerRadius"] = UDim.new(0, 15);


-- StarterGui.GoonHub.Main.panel.content.bar.user.list
G2L["3a"] = Instance.new("UIListLayout", G2L["38"]);
G2L["3a"]["Wraps"] = true;
G2L["3a"]["Padding"] = UDim.new(0, 10);
G2L["3a"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
G2L["3a"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
G2L["3a"]["Name"] = [[list]];


-- StarterGui.GoonHub.Main.panel.content.bar.user.padding
G2L["3b"] = Instance.new("UIPadding", G2L["38"]);
G2L["3b"]["PaddingRight"] = UDim.new(0, 30);
G2L["3b"]["Name"] = [[padding]];
G2L["3b"]["PaddingLeft"] = UDim.new(0, 18);


-- StarterGui.GoonHub.Main.panel.content.bar.user.info
G2L["3c"] = Instance.new("Frame", G2L["38"]);
G2L["3c"]["BorderSizePixel"] = 0;
G2L["3c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["3c"]["Size"] = UDim2.new(0.47325, 0, 1, 0);
G2L["3c"]["Position"] = UDim2.new(0.22222, 0, 0, 0);
G2L["3c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["3c"]["Name"] = [[info]];
G2L["3c"]["LayoutOrder"] = 5;
G2L["3c"]["BackgroundTransparency"] = 1;


-- StarterGui.GoonHub.Main.panel.content.bar.user.info.Flex
G2L["3d"] = Instance.new("UIFlexItem", G2L["3c"]);
G2L["3d"]["Name"] = [[Flex]];
G2L["3d"]["FlexMode"] = Enum.UIFlexMode.Fill;


-- StarterGui.GoonHub.Main.panel.content.bar.user.info.display
G2L["3e"] = Instance.new("TextLabel", G2L["3c"]);
G2L["3e"]["TextTruncate"] = Enum.TextTruncate.SplitWord;
G2L["3e"]["BorderSizePixel"] = 0;
G2L["3e"]["AutoLocalize"] = false;
G2L["3e"]["TextSize"] = 13;
G2L["3e"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["3e"]["TextYAlignment"] = Enum.TextYAlignment.Bottom;
G2L["3e"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["3e"]["FontFace"] = Font.new([[rbxassetid://12187365364]], Enum.FontWeight.Medium, Enum.FontStyle.Normal);
G2L["3e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["3e"]["BackgroundTransparency"] = 1;
G2L["3e"]["AnchorPoint"] = Vector2.new(0.5, 0);
G2L["3e"]["Size"] = UDim2.new(1, 0, 0, 0);
G2L["3e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["3e"]["Text"] = [[Display]];
G2L["3e"]["LayoutOrder"] = 2;
G2L["3e"]["Name"] = [[display]];
G2L["3e"]["Position"] = UDim2.new(0.5, 0, 0, 0);

-- StarterGui.GoonHub.Main.panel.content.bar.user.info.display.Flex
G2L["3f"] = Instance.new("UIFlexItem", G2L["3e"]);
G2L["3f"]["Name"] = [[Flex]];
G2L["3f"]["FlexMode"] = Enum.UIFlexMode.Fill;


-- StarterGui.GoonHub.Main.panel.content.bar.user.info.username
G2L["40"] = Instance.new("TextLabel", G2L["3c"]);
G2L["40"]["TextTruncate"] = Enum.TextTruncate.SplitWord;
G2L["40"]["BorderSizePixel"] = 0;
G2L["40"]["AutoLocalize"] = false;
G2L["40"]["TextSize"] = 10;
G2L["40"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["40"]["TextTransparency"] = 0.5;
G2L["40"]["TextYAlignment"] = Enum.TextYAlignment.Top;
G2L["40"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["40"]["FontFace"] = Font.new([[rbxassetid://12187365364]], Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
G2L["40"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["40"]["BackgroundTransparency"] = 1;
G2L["40"]["AnchorPoint"] = Vector2.new(0.5, 0);
G2L["40"]["Size"] = UDim2.new(1, 0, 0, 0);
G2L["40"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["40"]["Text"] = [[@username]];
G2L["40"]["LayoutOrder"] = 2;
G2L["40"]["Name"] = [[username]];
G2L["40"]["Position"] = UDim2.new(0.5, 0, 0, 0);

-- StarterGui.GoonHub.Main.panel.content.bar.user.info.username.Flex
G2L["41"] = Instance.new("UIFlexItem", G2L["40"]);
G2L["41"]["Name"] = [[Flex]];
G2L["41"]["FlexMode"] = Enum.UIFlexMode.Fill;


-- StarterGui.GoonHub.Main.panel.content.bar.user.info.list
G2L["42"] = Instance.new("UIListLayout", G2L["3c"]);
G2L["42"]["Wraps"] = true;
G2L["42"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
G2L["42"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
G2L["42"]["Name"] = [[list]];


-- StarterGui.GoonHub.Main.panel.content.bar.user.profile
G2L["43"] = Instance.new("ImageLabel", G2L["38"]);
G2L["43"]["BorderSizePixel"] = 0;
G2L["43"]["ScaleType"] = Enum.ScaleType.Crop;
G2L["43"]["BackgroundColor3"] = Color3.fromRGB(36, 36, 36);
G2L["43"]["ImageTransparency"] = 1;
G2L["43"]["AnchorPoint"] = Vector2.new(0, 0.5);
G2L["43"]["Size"] = UDim2.new(0, 26, 1, 0);
G2L["43"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["43"]["BackgroundTransparency"] = 1;
G2L["43"]["LayoutOrder"] = 1;
G2L["43"]["Name"] = [[profile]];
G2L["43"]["Position"] = UDim2.new(0, 0, 0.5, 0);


-- StarterGui.GoonHub.Main.panel.content.bar.user.profile.corner
G2L["44"] = Instance.new("UICorner", G2L["43"]);
G2L["44"]["Name"] = [[corner]];
G2L["44"]["CornerRadius"] = UDim.new(1, 0);


-- StarterGui.GoonHub.Main.panel.content.bar.user.profile.thumbnail
G2L["45"] = Instance.new("ImageLabel", G2L["43"]);
G2L["45"]["BorderSizePixel"] = 0;
G2L["45"]["ScaleType"] = Enum.ScaleType.Crop;
G2L["45"]["BackgroundColor3"] = Color3.fromRGB(36, 36, 36);
G2L["45"]["AnchorPoint"] = Vector2.new(0, 0.5);
G2L["45"]["Image"] = [[https://www.roblox.com/headshot-thumbnail/image?userId=3765399271&width=420&height=420&format=png]];
G2L["45"]["Size"] = UDim2.new(0, 26, 0, 26);
G2L["45"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["45"]["LayoutOrder"] = 1;
G2L["45"]["Name"] = [[thumbnail]];
G2L["45"]["Position"] = UDim2.new(0, 0, 0.5, 0);

-- StarterGui.GoonHub.Main.panel.content.bar.user.profile.thumbnail.corner
G2L["46"] = Instance.new("UICorner", G2L["45"]);
G2L["46"]["Name"] = [[corner]];
G2L["46"]["CornerRadius"] = UDim.new(1, 0);


-- StarterGui.GoonHub.Main.panel.content.bar.user.time
G2L["47"] = Instance.new("ImageButton", G2L["38"]);
G2L["47"]["BorderSizePixel"] = 0;
G2L["47"]["BackgroundTransparency"] = 0.8;
G2L["47"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["47"]["AutomaticSize"] = Enum.AutomaticSize.X;
G2L["47"]["Size"] = UDim2.new(0, 40, 0, 20);
G2L["47"]["LayoutOrder"] = 10;
G2L["47"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["47"]["Name"] = [[time]];
G2L["47"]["Position"] = UDim2.new(0.70165, 0, 0.34375, 0);


-- StarterGui.GoonHub.Main.panel.content.bar.user.time.corner
G2L["48"] = Instance.new("UICorner", G2L["47"]);
G2L["48"]["Name"] = [[corner]];
G2L["48"]["CornerRadius"] = UDim.new(0, 4);


-- StarterGui.GoonHub.Main.panel.content.bar.user.time.text
G2L["49"] = Instance.new("TextLabel", G2L["47"]);
G2L["49"]["TextWrapped"] = true;
G2L["49"]["BorderSizePixel"] = 0;
G2L["49"]["TextSize"] = 12;
G2L["49"]["TextTransparency"] = 0.2;
G2L["49"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["49"]["FontFace"] = Font.new([[rbxassetid://12187365364]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["49"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["49"]["BackgroundTransparency"] = 1;
G2L["49"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["49"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["49"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["49"]["Text"] = [[1:38 PM]];
G2L["49"]["AutomaticSize"] = Enum.AutomaticSize.X;
G2L["49"]["Name"] = [[text]];
G2L["49"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.GoonHub.Main.panel.content.bar.user.time.padding
G2L["4a"] = Instance.new("UIPadding", G2L["47"]);
G2L["4a"]["PaddingRight"] = UDim.new(0, 15);
G2L["4a"]["Name"] = [[padding]];
G2L["4a"]["PaddingLeft"] = UDim.new(0, 15);


-- StarterGui.GoonHub.Main.panel.content.bar.main
G2L["4b"] = Instance.new("Frame", G2L["16"]);
G2L["4b"]["BorderSizePixel"] = 0;
G2L["4b"]["BackgroundColor3"] = Color3.fromRGB(9, 9, 9);
G2L["4b"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["4b"]["AutomaticSize"] = Enum.AutomaticSize.Y;
G2L["4b"]["Size"] = UDim2.new(1, -22, 1, 0);
G2L["4b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["4b"]["Name"] = [[main]];
G2L["4b"]["LayoutOrder"] = 3;
G2L["4b"]["BackgroundTransparency"] = 0.7;


-- StarterGui.GoonHub.Main.panel.content.bar.main.navigation
G2L["4c"] = Instance.new("ScrollingFrame", G2L["4b"]);
G2L["4c"]["Active"] = true;
G2L["4c"]["ScrollingDirection"] = Enum.ScrollingDirection.Y;
G2L["4c"]["BorderSizePixel"] = 0;
G2L["4c"]["CanvasSize"] = UDim2.new(0, 0, 0, 0);
G2L["4c"]["Name"] = [[navigation]];
G2L["4c"]["ScrollBarImageTransparency"] = 1;
G2L["4c"]["BackgroundColor3"] = Color3.fromRGB(9, 9, 9);
G2L["4c"]["AnchorPoint"] = Vector2.new(0.5, 1);
G2L["4c"]["AutomaticCanvasSize"] = Enum.AutomaticSize.Y;
G2L["4c"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["4c"]["Position"] = UDim2.new(0.5, 0, 1, -10);
G2L["4c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["4c"]["ScrollBarThickness"] = 0;
G2L["4c"]["LayoutOrder"] = 3;
G2L["4c"]["BackgroundTransparency"] = 1;

-- StarterGui.GoonHub.Main.panel.content.bar.main.navigation.main
G2L["4d"] = Instance.new("Frame", G2L["4c"]);
G2L["4d"]["BorderSizePixel"] = 0;
G2L["4d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["4d"]["AnchorPoint"] = Vector2.new(0.5, 0);
G2L["4d"]["AutomaticSize"] = Enum.AutomaticSize.Y;
G2L["4d"]["Size"] = UDim2.new(1, 0, 0, 0);
G2L["4d"]["Position"] = UDim2.new(0.5, 0, 0, 0);
G2L["4d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["4d"]["Name"] = [[main]];
G2L["4d"]["BackgroundTransparency"] = 1;


-- StarterGui.GoonHub.Main.panel.content.bar.main.navigation.main.home
G2L["4e"] = Instance.new("ImageButton", G2L["4d"]);
G2L["4e"]["SliceScale"] = 0.01;
G2L["4e"]["BorderSizePixel"] = 0;
G2L["4e"]["SliceCenter"] = Rect.new(512, 512, 512, 512);
G2L["4e"]["ScaleType"] = Enum.ScaleType.Slice;
G2L["4e"]["AutoButtonColor"] = false;
G2L["4e"]["ImageTransparency"] = 1;
G2L["4e"]["BackgroundColor3"] = Color3.fromRGB(41, 41, 41);
G2L["4e"]["ImageColor3"] = Color3.fromRGB(0, 0, 0);
G2L["4e"]["Image"] = [[rbxassetid://125088425775676]];
G2L["4e"]["Size"] = UDim2.new(1, 0, 0, 31);
G2L["4e"]["LayoutOrder"] = 1;
G2L["4e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["4e"]["Name"] = [[home]];

-- StarterGui.GoonHub.Main.panel.content.bar.main.navigation.main.home.list
G2L["4f"] = Instance.new("UIListLayout", G2L["4e"]);
G2L["4f"]["Padding"] = UDim.new(0, 10);
G2L["4f"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
G2L["4f"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
G2L["4f"]["Name"] = [[list]];
G2L["4f"]["FillDirection"] = Enum.FillDirection.Horizontal;


-- StarterGui.GoonHub.Main.panel.content.bar.main.navigation.main.home.padding
G2L["50"] = Instance.new("UIPadding", G2L["4e"]);
G2L["50"]["PaddingRight"] = UDim.new(0, 12);
G2L["50"]["Name"] = [[padding]];
G2L["50"]["PaddingLeft"] = UDim.new(0, 12);


-- StarterGui.GoonHub.Main.panel.content.bar.main.navigation.main.home.label
G2L["51"] = Instance.new("TextLabel", G2L["4e"]);
G2L["51"]["BorderSizePixel"] = 0;
G2L["51"]["AutoLocalize"] = false;
G2L["51"]["TextSize"] = 14;
G2L["51"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["51"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["51"]["FontFace"] = Font.new([[rbxassetid://12187365364]], Enum.FontWeight.Medium, Enum.FontStyle.Normal);
G2L["51"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["51"]["BackgroundTransparency"] = 1;
G2L["51"]["Size"] = UDim2.new(0, 0, 0, 22);
G2L["51"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["51"]["Text"] = [[Home]];
G2L["51"]["LayoutOrder"] = 2;
G2L["51"]["Name"] = [[label]];
G2L["51"]["Position"] = UDim2.new(0.16667, 0, 0, 0);

-- StarterGui.GoonHub.Main.panel.content.bar.main.navigation.main.home.label.Flex
G2L["52"] = Instance.new("UIFlexItem", G2L["51"]);
G2L["52"]["Name"] = [[Flex]];
G2L["52"]["FlexMode"] = Enum.UIFlexMode.Fill;


-- StarterGui.GoonHub.Main.panel.content.bar.main.navigation.main.home.Screen
G2L["53"] = Instance.new("ObjectValue", G2L["4e"]);
G2L["53"]["Name"] = [[Screen]];
-- [ERROR] cannot convert Value, please report to "https://github.com/uniquadev/GuiToLuaConverter/issues"


-- StarterGui.GoonHub.Main.panel.content.bar.main.navigation.main.home.corner
G2L["54"] = Instance.new("UICorner", G2L["4e"]);
G2L["54"]["Name"] = [[corner]];
G2L["54"]["CornerRadius"] = UDim.new(0, 12);


-- StarterGui.GoonHub.Main.panel.content.bar.main.navigation.main.home.holder
G2L["55"] = Instance.new("ImageLabel", G2L["4e"]);
G2L["55"]["BorderSizePixel"] = 0;
G2L["55"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["55"]["ImageTransparency"] = 1;
G2L["55"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["55"]["Size"] = UDim2.new(0, 20, 0, 20);
G2L["55"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["55"]["BackgroundTransparency"] = 0.8;
G2L["55"]["LayoutOrder"] = 1;
G2L["55"]["Name"] = [[holder]];


-- StarterGui.GoonHub.Main.panel.content.bar.main.navigation.main.home.holder.icon
G2L["56"] = Instance.new("ImageLabel", G2L["55"]);
G2L["56"]["BorderSizePixel"] = 0;
G2L["56"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["56"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["56"]["Image"] = [[rbxassetid://11433532654]];
G2L["56"]["Size"] = UDim2.new(0, 14, 0, 14);
G2L["56"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["56"]["BackgroundTransparency"] = 1;
G2L["56"]["LayoutOrder"] = 1;
G2L["56"]["Name"] = [[icon]];
G2L["56"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.GoonHub.Main.panel.content.bar.main.navigation.main.home.holder.Corner
G2L["57"] = Instance.new("UICorner", G2L["55"]);
G2L["57"]["Name"] = [[Corner]];
G2L["57"]["CornerRadius"] = UDim.new(0, 6);


-- StarterGui.GoonHub.Main.panel.content.bar.main.navigation.main.home.icons
G2L["58"] = Instance.new("Frame", G2L["4e"]);
G2L["58"]["BorderSizePixel"] = 0;
G2L["58"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["58"]["Size"] = UDim2.new(0, 0, 0, 22);
G2L["58"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["58"]["Name"] = [[icons]];
G2L["58"]["LayoutOrder"] = 9;


-- StarterGui.GoonHub.Main.panel.content.bar.main.navigation.main.home.icons.list
G2L["59"] = Instance.new("UIListLayout", G2L["58"]);
G2L["59"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Right;
G2L["59"]["Padding"] = UDim.new(0, 10);
G2L["59"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
G2L["59"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
G2L["59"]["Name"] = [[list]];
G2L["59"]["FillDirection"] = Enum.FillDirection.Horizontal;


-- StarterGui.GoonHub.Main.panel.content.bar.main.navigation.main.home.icons.warning
G2L["5a"] = Instance.new("ImageLabel", G2L["58"]);
G2L["5a"]["BorderSizePixel"] = 0;
G2L["5a"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["5a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["5a"]["ImageTransparency"] = 0.5;
G2L["5a"]["ImageColor3"] = Color3.fromRGB(255, 192, 0);
G2L["5a"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["5a"]["Image"] = [[rbxassetid://11419713314]];
G2L["5a"]["Size"] = UDim2.new(0, 16, 0, 16);
G2L["5a"]["Visible"] = false;
G2L["5a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["5a"]["BackgroundTransparency"] = 1;
G2L["5a"]["Name"] = [[warning]];
G2L["5a"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.GoonHub.Main.panel.content.bar.main.navigation.main.home.icons.loading
G2L["5b"] = Instance.new("ImageLabel", G2L["58"]);
G2L["5b"]["BorderSizePixel"] = 0;
G2L["5b"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["5b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["5b"]["ImageTransparency"] = 0.5;
G2L["5b"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["5b"]["Image"] = [[rbxassetid://11963357970]];
G2L["5b"]["Size"] = UDim2.new(0, 16, 0, 16);
G2L["5b"]["Visible"] = false;
G2L["5b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["5b"]["BackgroundTransparency"] = 1;
G2L["5b"]["Name"] = [[loading]];
G2L["5b"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.GoonHub.Main.panel.content.bar.main.navigation.main.list
G2L["5c"] = Instance.new("UIListLayout", G2L["4d"]);
G2L["5c"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
G2L["5c"]["Padding"] = UDim.new(0, 5);
G2L["5c"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
G2L["5c"]["Name"] = [[list]];


-- StarterGui.GoonHub.Main.panel.content.bar.main.navigation.main.padding
G2L["5d"] = Instance.new("UIPadding", G2L["4d"]);
G2L["5d"]["PaddingTop"] = UDim.new(0, 2);
G2L["5d"]["PaddingRight"] = UDim.new(0, 8);
G2L["5d"]["Name"] = [[padding]];
G2L["5d"]["PaddingLeft"] = UDim.new(0, 8);


-- StarterGui.GoonHub.Main.panel.content.bar.main.navigation.UIListLayout
G2L["5e"] = Instance.new("UIListLayout", G2L["4c"]);
G2L["5e"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
G2L["5e"]["SortOrder"] = Enum.SortOrder.LayoutOrder;


-- StarterGui.GoonHub.Main.panel.content.bar.main.navigation.flex
G2L["5f"] = Instance.new("UIFlexItem", G2L["4c"]);
G2L["5f"]["Name"] = [[flex]];
G2L["5f"]["FlexMode"] = Enum.UIFlexMode.Fill;


-- StarterGui.GoonHub.Main.panel.content.bar.main.list
G2L["60"] = Instance.new("UIListLayout", G2L["4b"]);
G2L["60"]["Padding"] = UDim.new(0, 10);
G2L["60"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
G2L["60"]["Name"] = [[list]];


-- StarterGui.GoonHub.Main.panel.content.bar.main.Corner
G2L["61"] = Instance.new("UICorner", G2L["4b"]);
G2L["61"]["Name"] = [[Corner]];
G2L["61"]["CornerRadius"] = UDim.new(0, 15);


-- StarterGui.GoonHub.Main.panel.content.bar.main.flex
G2L["62"] = Instance.new("UIFlexItem", G2L["4b"]);
G2L["62"]["Name"] = [[flex]];
G2L["62"]["FlexMode"] = Enum.UIFlexMode.Fill;


-- StarterGui.GoonHub.Main.panel.content.bar.main.padding
G2L["63"] = Instance.new("UIPadding", G2L["4b"]);
G2L["63"]["PaddingTop"] = UDim.new(0, 8);
G2L["63"]["Name"] = [[padding]];
G2L["63"]["PaddingBottom"] = UDim.new(0, 8);


-- StarterGui.GoonHub.Main.panel.content.Padding
G2L["64"] = Instance.new("UIPadding", G2L["10"]);
G2L["64"]["PaddingTop"] = UDim.new(0, 10);
G2L["64"]["PaddingRight"] = UDim.new(0, 15);
G2L["64"]["Name"] = [[Padding]];
G2L["64"]["PaddingBottom"] = UDim.new(0, 10);


-- StarterGui.GoonHub.Main.panel.content.topbar
G2L["65"] = Instance.new("ImageButton", G2L["10"]);
G2L["65"]["BorderSizePixel"] = 0;
G2L["65"]["AutoButtonColor"] = false;
G2L["65"]["ImageTransparency"] = 1;
G2L["65"]["BackgroundTransparency"] = 0.9;
G2L["65"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["65"]["ZIndex"] = 2;
G2L["65"]["AnchorPoint"] = Vector2.new(0.5, 0);
G2L["65"]["Size"] = UDim2.new(1.0219, 0, 0, 35);
G2L["65"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["65"]["Name"] = [[topbar]];
G2L["65"]["Position"] = UDim2.new(0.51095, 0, -0.11098, 0);


-- StarterGui.GoonHub.Main.panel.content.topbar.weather
G2L["66"] = Instance.new("ImageLabel", G2L["65"]);
G2L["66"]["BorderSizePixel"] = 0;
G2L["66"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["66"]["AnchorPoint"] = Vector2.new(1, 0.5);
G2L["66"]["Image"] = [[rbxassetid://13056160366]];
G2L["66"]["Size"] = UDim2.new(0.6, 0, 0.6, 0);
G2L["66"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["66"]["BackgroundTransparency"] = 1;
G2L["66"]["LayoutOrder"] = 4;
G2L["66"]["Name"] = [[weather]];
G2L["66"]["Position"] = UDim2.new(1, -18, 0.5, 0);


-- StarterGui.GoonHub.Main.panel.content.topbar.weather.aspect
G2L["67"] = Instance.new("UIAspectRatioConstraint", G2L["66"]);
G2L["67"]["Name"] = [[aspect]];


-- StarterGui.GoonHub.Main.panel.content.topbar.List
G2L["68"] = Instance.new("UIListLayout", G2L["65"]);
G2L["68"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
G2L["68"]["Padding"] = UDim.new(0, 10);
G2L["68"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
G2L["68"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
G2L["68"]["Name"] = [[List]];
G2L["68"]["FillDirection"] = Enum.FillDirection.Horizontal;


-- StarterGui.GoonHub.Main.panel.content.topbar.space
G2L["69"] = Instance.new("Frame", G2L["65"]);
G2L["69"]["BorderSizePixel"] = 0;
G2L["69"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["69"]["Size"] = UDim2.new(0, 0, 1, 0);
G2L["69"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["69"]["Name"] = [[space]];
G2L["69"]["LayoutOrder"] = 2;
G2L["69"]["BackgroundTransparency"] = 1;


-- StarterGui.GoonHub.Main.panel.content.topbar.space.Flex
G2L["6a"] = Instance.new("UIFlexItem", G2L["69"]);
G2L["6a"]["Name"] = [[Flex]];
G2L["6a"]["FlexMode"] = Enum.UIFlexMode.Fill;


-- StarterGui.GoonHub.Main.panel.content.topbar.Padding
G2L["6b"] = Instance.new("UIPadding", G2L["65"]);
G2L["6b"]["PaddingRight"] = UDim.new(0, 15);
G2L["6b"]["Name"] = [[Padding]];
G2L["6b"]["PaddingLeft"] = UDim.new(0, 15);


-- StarterGui.GoonHub.Main.panel.content.topbar.logo
G2L["6c"] = Instance.new("Frame", G2L["65"]);
G2L["6c"]["BorderSizePixel"] = 0;
G2L["6c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["6c"]["AutomaticSize"] = Enum.AutomaticSize.X;
G2L["6c"]["Size"] = UDim2.new(0, 80, 1, 0);
G2L["6c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["6c"]["Name"] = [[logo]];
G2L["6c"]["LayoutOrder"] = 3;
G2L["6c"]["BackgroundTransparency"] = 1;


-- StarterGui.GoonHub.Main.panel.content.topbar.logo.TextLabel
G2L["6d"] = Instance.new("TextLabel", G2L["6c"]);
G2L["6d"]["BorderSizePixel"] = 0;
G2L["6d"]["TextSize"] = 21;
G2L["6d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["6d"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["6d"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["6d"]["BackgroundTransparency"] = 1;
G2L["6d"]["Size"] = UDim2.new(0, 95, 0, 31);
G2L["6d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["6d"]["Text"] = [[GoonHub]];
G2L["6d"]["Position"] = UDim2.new(0.04124, 0, 0, 0);


-- StarterGui.GoonHub.Main.panel.content.topbar.actions
G2L["6e"] = Instance.new("Frame", G2L["65"]);
G2L["6e"]["BorderSizePixel"] = 0;
G2L["6e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["6e"]["AnchorPoint"] = Vector2.new(0, 0.5);
G2L["6e"]["AutomaticSize"] = Enum.AutomaticSize.XY;
G2L["6e"]["Size"] = UDim2.new(0, 0, 1, 0);
G2L["6e"]["Position"] = UDim2.new(0, 18, 0.5, 0);
G2L["6e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["6e"]["Name"] = [[actions]];
G2L["6e"]["BackgroundTransparency"] = 1;


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.list
G2L["6f"] = Instance.new("UIListLayout", G2L["6e"]);
G2L["6f"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
G2L["6f"]["Padding"] = UDim.new(0, 4);
G2L["6f"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
G2L["6f"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
G2L["6f"]["Name"] = [[list]];
G2L["6f"]["FillDirection"] = Enum.FillDirection.Horizontal;


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main
G2L["70"] = Instance.new("Frame", G2L["6e"]);
G2L["70"]["BorderSizePixel"] = 0;
G2L["70"]["BackgroundColor3"] = Color3.fromRGB(25, 25, 25);
G2L["70"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["70"]["AutomaticSize"] = Enum.AutomaticSize.X;
G2L["70"]["Size"] = UDim2.new(0, 0, 0, 27);
G2L["70"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["70"]["Name"] = [[main]];


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.list
G2L["71"] = Instance.new("UIListLayout", G2L["70"]);
G2L["71"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
G2L["71"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
G2L["71"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
G2L["71"]["Name"] = [[list]];
G2L["71"]["FillDirection"] = Enum.FillDirection.Horizontal;


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.close
G2L["72"] = Instance.new("ImageButton", G2L["70"]);
G2L["72"]["BorderSizePixel"] = 0;
G2L["72"]["ImageTransparency"] = 1;
G2L["72"]["BackgroundTransparency"] = 1;
G2L["72"]["BackgroundColor3"] = Color3.fromRGB(255, 0, 0);
G2L["72"]["Size"] = UDim2.new(0, 22, 0, 22);
G2L["72"]["LayoutOrder"] = 1;
G2L["72"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["72"]["Name"] = [[close]];

-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.close.scale
G2L["73"] = Instance.new("UIScale", G2L["72"]);
G2L["73"]["Name"] = [[scale]];


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.close.corner
G2L["74"] = Instance.new("UICorner", G2L["72"]);
G2L["74"]["Name"] = [[corner]];
G2L["74"]["CornerRadius"] = UDim.new(0, 5);


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.close.icon
G2L["75"] = Instance.new("Frame", G2L["72"]);
G2L["75"]["BorderSizePixel"] = 0;
G2L["75"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["75"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["75"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["75"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["75"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["75"]["Name"] = [[icon]];
G2L["75"]["BackgroundTransparency"] = 1;


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.close.icon.circle
G2L["76"] = Instance.new("ImageLabel", G2L["75"]);
G2L["76"]["BorderSizePixel"] = 0;
G2L["76"]["BackgroundColor3"] = Color3.fromRGB(255, 51, 51);
G2L["76"]["ImageTransparency"] = 1;
G2L["76"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["76"]["Size"] = UDim2.new(0, 18, 0, 18);
G2L["76"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["76"]["Name"] = [[circle]];
G2L["76"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.close.icon.circle.corner
G2L["77"] = Instance.new("UICorner", G2L["76"]);
G2L["77"]["Name"] = [[corner]];
G2L["77"]["CornerRadius"] = UDim.new(1, 0);


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.close.icon.inner
G2L["78"] = Instance.new("ImageLabel", G2L["75"]);
G2L["78"]["ZIndex"] = 2;
G2L["78"]["BorderSizePixel"] = 0;
G2L["78"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["78"]["ImageTransparency"] = 0.2;
G2L["78"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["78"]["Size"] = UDim2.new(0, 14, 0, 14);
G2L["78"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["78"]["BackgroundTransparency"] = 1;
G2L["78"]["Name"] = [[inner]];
G2L["78"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.close.icon.inner.stroke
G2L["79"] = Instance.new("UIStroke", G2L["78"]);
G2L["79"]["Transparency"] = 0.5;
G2L["79"]["Name"] = [[stroke]];


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.close.icon.inner.corner
G2L["7a"] = Instance.new("UICorner", G2L["78"]);
G2L["7a"]["Name"] = [[corner]];
G2L["7a"]["CornerRadius"] = UDim.new(1, 0);


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.close.icon.icon
G2L["7b"] = Instance.new("ImageLabel", G2L["75"]);
G2L["7b"]["ZIndex"] = 2;
G2L["7b"]["BorderSizePixel"] = 0;
G2L["7b"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["7b"]["ImageTransparency"] = 0.5;
G2L["7b"]["ImageColor3"] = Color3.fromRGB(0, 0, 0);
G2L["7b"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["7b"]["Image"] = [[rbxassetid://109757326745560]];
G2L["7b"]["Size"] = UDim2.new(0, 8, 0, 8);
G2L["7b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["7b"]["BackgroundTransparency"] = 1;
G2L["7b"]["Name"] = [[icon]];
G2L["7b"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.return
G2L["7c"] = Instance.new("ImageButton", G2L["70"]);
G2L["7c"]["BorderSizePixel"] = 0;
G2L["7c"]["ImageTransparency"] = 1;
G2L["7c"]["BackgroundTransparency"] = 1;
G2L["7c"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["7c"]["Size"] = UDim2.new(0, 22, 0, 22);
G2L["7c"]["LayoutOrder"] = 5;
G2L["7c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["7c"]["Name"] = [[return]];

-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.return.corner
G2L["7d"] = Instance.new("UICorner", G2L["7c"]);
G2L["7d"]["Name"] = [[corner]];
G2L["7d"]["CornerRadius"] = UDim.new(0, 5);


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.return.scale
G2L["7e"] = Instance.new("UIScale", G2L["7c"]);
G2L["7e"]["Name"] = [[scale]];


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.return.icon
G2L["7f"] = Instance.new("ImageLabel", G2L["7c"]);
G2L["7f"]["ZIndex"] = 2;
G2L["7f"]["BorderSizePixel"] = 0;
G2L["7f"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["7f"]["ImageTransparency"] = 0.5;
G2L["7f"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["7f"]["Image"] = [[rbxassetid://136962996761231]];
G2L["7f"]["Size"] = UDim2.new(0.75, 0, 0.75, 0);
G2L["7f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["7f"]["BackgroundTransparency"] = 1;
G2L["7f"]["Name"] = [[icon]];
G2L["7f"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.nav
G2L["80"] = Instance.new("ImageButton", G2L["70"]);
G2L["80"]["BorderSizePixel"] = 0;
G2L["80"]["ImageTransparency"] = 1;
G2L["80"]["BackgroundTransparency"] = 1;
G2L["80"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 0);
G2L["80"]["Size"] = UDim2.new(0, 22, 0, 22);
G2L["80"]["LayoutOrder"] = 1;
G2L["80"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["80"]["Name"] = [[nav]];

-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.nav.scale
G2L["81"] = Instance.new("UIScale", G2L["80"]);
G2L["81"]["Name"] = [[scale]];


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.nav.corner
G2L["82"] = Instance.new("UICorner", G2L["80"]);
G2L["82"]["Name"] = [[corner]];
G2L["82"]["CornerRadius"] = UDim.new(0, 5);


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.nav.icon
G2L["83"] = Instance.new("Frame", G2L["80"]);
G2L["83"]["BorderSizePixel"] = 0;
G2L["83"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["83"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["83"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["83"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["83"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["83"]["Name"] = [[icon]];
G2L["83"]["BackgroundTransparency"] = 1;


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.nav.icon.circle
G2L["84"] = Instance.new("ImageLabel", G2L["83"]);
G2L["84"]["BorderSizePixel"] = 0;
G2L["84"]["BackgroundColor3"] = Color3.fromRGB(226, 183, 26);
G2L["84"]["ImageTransparency"] = 1;
G2L["84"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["84"]["Size"] = UDim2.new(0, 18, 0, 18);
G2L["84"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["84"]["Name"] = [[circle]];
G2L["84"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.nav.icon.circle.corner
G2L["85"] = Instance.new("UICorner", G2L["84"]);
G2L["85"]["Name"] = [[corner]];
G2L["85"]["CornerRadius"] = UDim.new(1, 0);


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.nav.icon.icon
G2L["86"] = Instance.new("ImageLabel", G2L["83"]);
G2L["86"]["ZIndex"] = 2;
G2L["86"]["BorderSizePixel"] = 0;
G2L["86"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["86"]["ImageTransparency"] = 0.5;
G2L["86"]["ImageColor3"] = Color3.fromRGB(0, 0, 0);
G2L["86"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["86"]["Image"] = [[rbxassetid://4773248567]];
G2L["86"]["Size"] = UDim2.new(0, 10, 0, 10);
G2L["86"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["86"]["BackgroundTransparency"] = 1;
G2L["86"]["Name"] = [[icon]];
G2L["86"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.nav.icon.inner
G2L["87"] = Instance.new("ImageLabel", G2L["83"]);
G2L["87"]["ZIndex"] = 2;
G2L["87"]["BorderSizePixel"] = 0;
G2L["87"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["87"]["ImageTransparency"] = 0.2;
G2L["87"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["87"]["Size"] = UDim2.new(0, 14, 0, 14);
G2L["87"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["87"]["BackgroundTransparency"] = 1;
G2L["87"]["Name"] = [[inner]];
G2L["87"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.nav.icon.inner.corner
G2L["88"] = Instance.new("UICorner", G2L["87"]);
G2L["88"]["Name"] = [[corner]];
G2L["88"]["CornerRadius"] = UDim.new(1, 0);


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.nav.icon.inner.stroke
G2L["89"] = Instance.new("UIStroke", G2L["87"]);
G2L["89"]["Transparency"] = 0.5;
G2L["89"]["Name"] = [[stroke]];


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.window
G2L["8a"] = Instance.new("ImageButton", G2L["70"]);
G2L["8a"]["BorderSizePixel"] = 0;
G2L["8a"]["Visible"] = false;
G2L["8a"]["ImageTransparency"] = 1;
G2L["8a"]["BackgroundTransparency"] = 1;
G2L["8a"]["BackgroundColor3"] = Color3.fromRGB(0, 255, 0);
G2L["8a"]["Size"] = UDim2.new(0, 22, 0, 22);
G2L["8a"]["LayoutOrder"] = 1;
G2L["8a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["8a"]["Name"] = [[window]];

-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.window.scale
G2L["8b"] = Instance.new("UIScale", G2L["8a"]);
G2L["8b"]["Name"] = [[scale]];


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.window.corner
G2L["8c"] = Instance.new("UICorner", G2L["8a"]);
G2L["8c"]["Name"] = [[corner]];
G2L["8c"]["CornerRadius"] = UDim.new(0, 5);


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.window.icon
G2L["8d"] = Instance.new("Frame", G2L["8a"]);
G2L["8d"]["BorderSizePixel"] = 0;
G2L["8d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["8d"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["8d"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["8d"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["8d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["8d"]["Name"] = [[icon]];
G2L["8d"]["BackgroundTransparency"] = 1;


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.window.icon.circle
G2L["8e"] = Instance.new("ImageLabel", G2L["8d"]);
G2L["8e"]["BorderSizePixel"] = 0;
G2L["8e"]["BackgroundColor3"] = Color3.fromRGB(122, 214, 3);
G2L["8e"]["ImageTransparency"] = 1;
G2L["8e"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["8e"]["Size"] = UDim2.new(0, 18, 0, 18);
G2L["8e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["8e"]["Name"] = [[circle]];
G2L["8e"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.window.icon.circle.corner
G2L["8f"] = Instance.new("UICorner", G2L["8e"]);
G2L["8f"]["Name"] = [[corner]];
G2L["8f"]["CornerRadius"] = UDim.new(1, 0);


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.window.icon.icon
G2L["90"] = Instance.new("ImageLabel", G2L["8d"]);
G2L["90"]["ZIndex"] = 2;
G2L["90"]["BorderSizePixel"] = 0;
G2L["90"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["90"]["ImageTransparency"] = 0.2;
G2L["90"]["ImageColor3"] = Color3.fromRGB(0, 0, 0);
G2L["90"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["90"]["Image"] = [[rbxassetid://11293980042]];
G2L["90"]["Size"] = UDim2.new(0, 10, 0, 10);
G2L["90"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["90"]["BackgroundTransparency"] = 1;
G2L["90"]["Name"] = [[icon]];
G2L["90"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.window.icon.inner
G2L["91"] = Instance.new("ImageLabel", G2L["8d"]);
G2L["91"]["ZIndex"] = 2;
G2L["91"]["BorderSizePixel"] = 0;
G2L["91"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["91"]["ImageTransparency"] = 0.2;
G2L["91"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["91"]["Size"] = UDim2.new(0, 14, 0, 14);
G2L["91"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["91"]["BackgroundTransparency"] = 1;
G2L["91"]["Name"] = [[inner]];
G2L["91"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.window.icon.inner.corner
G2L["92"] = Instance.new("UICorner", G2L["91"]);
G2L["92"]["Name"] = [[corner]];
G2L["92"]["CornerRadius"] = UDim.new(1, 0);


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.window.icon.inner.stroke
G2L["93"] = Instance.new("UIStroke", G2L["91"]);
G2L["93"]["Transparency"] = 0.5;
G2L["93"]["Name"] = [[stroke]];


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.fullscreen
G2L["94"] = Instance.new("ImageButton", G2L["70"]);
G2L["94"]["BorderSizePixel"] = 0;
G2L["94"]["ImageTransparency"] = 1;
G2L["94"]["BackgroundTransparency"] = 1;
G2L["94"]["BackgroundColor3"] = Color3.fromRGB(0, 255, 0);
G2L["94"]["Size"] = UDim2.new(0, 22, 0, 22);
G2L["94"]["LayoutOrder"] = 1;
G2L["94"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["94"]["Name"] = [[fullscreen]];


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.fullscreen.scale
G2L["95"] = Instance.new("UIScale", G2L["94"]);
G2L["95"]["Name"] = [[scale]];


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.fullscreen.corner
G2L["96"] = Instance.new("UICorner", G2L["94"]);
G2L["96"]["Name"] = [[corner]];
G2L["96"]["CornerRadius"] = UDim.new(0, 5);


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.fullscreen.icon
G2L["97"] = Instance.new("Frame", G2L["94"]);
G2L["97"]["BorderSizePixel"] = 0;
G2L["97"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["97"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["97"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["97"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["97"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["97"]["Name"] = [[icon]];
G2L["97"]["BackgroundTransparency"] = 1;


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.fullscreen.icon.circle
G2L["98"] = Instance.new("ImageLabel", G2L["97"]);
G2L["98"]["BorderSizePixel"] = 0;
G2L["98"]["BackgroundColor3"] = Color3.fromRGB(122, 214, 3);
G2L["98"]["ImageTransparency"] = 1;
G2L["98"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["98"]["Size"] = UDim2.new(0, 18, 0, 18);
G2L["98"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["98"]["Name"] = [[circle]];
G2L["98"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.fullscreen.icon.circle.corner
G2L["99"] = Instance.new("UICorner", G2L["98"]);
G2L["99"]["Name"] = [[corner]];
G2L["99"]["CornerRadius"] = UDim.new(1, 0);



-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.fullscreen.icon.icon
G2L["9a"] = Instance.new("ImageLabel", G2L["97"]);
G2L["9a"]["ZIndex"] = 2;
G2L["9a"]["BorderSizePixel"] = 0;
G2L["9a"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["9a"]["ImageTransparency"] = 0.2;
G2L["9a"]["ImageColor3"] = Color3.fromRGB(0, 0, 0);
G2L["9a"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["9a"]["Image"] = [[rbxassetid://11295291707]];
G2L["9a"]["Size"] = UDim2.new(0, 10, 0, 10);
G2L["9a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["9a"]["BackgroundTransparency"] = 1;
G2L["9a"]["Name"] = [[icon]];
G2L["9a"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.fullscreen.icon.inner
G2L["9b"] = Instance.new("ImageLabel", G2L["97"]);
G2L["9b"]["ZIndex"] = 2;
G2L["9b"]["BorderSizePixel"] = 0;
G2L["9b"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["9b"]["ImageTransparency"] = 0.2;
G2L["9b"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["9b"]["Size"] = UDim2.new(0, 14, 0, 14);
G2L["9b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["9b"]["BackgroundTransparency"] = 1;
G2L["9b"]["Name"] = [[inner]];
G2L["9b"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.fullscreen.icon.inner.corner
G2L["9c"] = Instance.new("UICorner", G2L["9b"]);
G2L["9c"]["Name"] = [[corner]];
G2L["9c"]["CornerRadius"] = UDim.new(1, 0);


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.fullscreen.icon.inner.stroke
G2L["9d"] = Instance.new("UIStroke", G2L["9b"]);
G2L["9d"]["Transparency"] = 0.5;
G2L["9d"]["Name"] = [[stroke]];


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.padding
G2L["9e"] = Instance.new("UIPadding", G2L["70"]);
G2L["9e"]["PaddingTop"] = UDim.new(0, 5);
G2L["9e"]["PaddingRight"] = UDim.new(0, 4);
G2L["9e"]["Name"] = [[padding]];
G2L["9e"]["PaddingLeft"] = UDim.new(0, 4);
G2L["9e"]["PaddingBottom"] = UDim.new(0, 5);


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.corner
G2L["9f"] = Instance.new("UICorner", G2L["70"]);
G2L["9f"]["Name"] = [[corner]];
G2L["9f"]["CornerRadius"] = UDim.new(1, 0);


-- StarterGui.GoonHub.Main.panel.content.topbar.actions.main.space
G2L["a0"] = Instance.new("Frame", G2L["70"]);
G2L["a0"]["BorderSizePixel"] = 0;
G2L["a0"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["a0"]["Size"] = UDim2.new(0, 5, 1, 0);
G2L["a0"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["a0"]["Name"] = [[space]];
G2L["a0"]["LayoutOrder"] = 4;
G2L["a0"]["BackgroundTransparency"] = 1;


-- StarterGui.GoonHub.Main.panel.debug
G2L["a1"] = Instance.new("Frame", G2L["4"]);
G2L["a1"]["Visible"] = false;
G2L["a1"]["BorderSizePixel"] = 0;
G2L["a1"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["a1"]["AnchorPoint"] = Vector2.new(0, 1);
G2L["a1"]["ClipsDescendants"] = true;
G2L["a1"]["Size"] = UDim2.new(1, 0, 0, 30);
G2L["a1"]["Position"] = UDim2.new(0, 0, 1, 0);
G2L["a1"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["a1"]["Name"] = [[debug]];
G2L["a1"]["LayoutOrder"] = 4;
G2L["a1"]["BackgroundTransparency"] = 0.9;


-- StarterGui.GoonHub.Main.panel.debug.list
G2L["a2"] = Instance.new("UIListLayout", G2L["a1"]);
G2L["a2"]["Padding"] = UDim.new(0, 6);
G2L["a2"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
G2L["a2"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
G2L["a2"]["Name"] = [[list]];
G2L["a2"]["FillDirection"] = Enum.FillDirection.Horizontal;


-- StarterGui.GoonHub.Main.panel.debug.divider
G2L["a3"] = Instance.new("UIStroke", G2L["a1"]);
G2L["a3"]["Thickness"] = 1.5;
G2L["a3"]["Color"] = Color3.fromRGB(46, 46, 46);
G2L["a3"]["Name"] = [[divider]];


-- StarterGui.GoonHub.Main.panel.debug.padding
G2L["a4"] = Instance.new("UIPadding", G2L["a1"]);
G2L["a4"]["PaddingTop"] = UDim.new(0.225, 0);
G2L["a4"]["PaddingRight"] = UDim.new(0.03, 20);
G2L["a4"]["Name"] = [[padding]];
G2L["a4"]["PaddingLeft"] = UDim.new(0.03, 0);
G2L["a4"]["PaddingBottom"] = UDim.new(0.3, 0);


-- StarterGui.GoonHub.Main.panel.debug.errors
G2L["a5"] = Instance.new("Frame", G2L["a1"]);
G2L["a5"]["BorderSizePixel"] = 0;
G2L["a5"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["a5"]["Size"] = UDim2.new(0.06, 0, 1, 0);
G2L["a5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["a5"]["Name"] = [[errors]];
G2L["a5"]["LayoutOrder"] = 1;
G2L["a5"]["BackgroundTransparency"] = 1;


-- StarterGui.GoonHub.Main.panel.debug.errors.list
G2L["a6"] = Instance.new("UIListLayout", G2L["a5"]);
G2L["a6"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
G2L["a6"]["Padding"] = UDim.new(0, 8);
G2L["a6"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
G2L["a6"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
G2L["a6"]["Name"] = [[list]];
G2L["a6"]["FillDirection"] = Enum.FillDirection.Horizontal;


-- StarterGui.GoonHub.Main.panel.debug.errors.icon
G2L["a7"] = Instance.new("ImageLabel", G2L["a5"]);
G2L["a7"]["BorderSizePixel"] = 0;
G2L["a7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["a7"]["ImageColor3"] = Color3.fromRGB(255, 81, 81);
G2L["a7"]["Image"] = [[rbxassetid://14563958666]];
G2L["a7"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["a7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["a7"]["BackgroundTransparency"] = 1;
G2L["a7"]["LayoutOrder"] = 1;
G2L["a7"]["Name"] = [[icon]];


-- StarterGui.GoonHub.Main.panel.debug.errors.icon.aspect
G2L["a8"] = Instance.new("UIAspectRatioConstraint", G2L["a7"]);
G2L["a8"]["Name"] = [[aspect]];


-- StarterGui.GoonHub.Main.panel.debug.errors.value
G2L["a9"] = Instance.new("TextLabel", G2L["a5"]);
G2L["a9"]["TextWrapped"] = true;
G2L["a9"]["TextTruncate"] = Enum.TextTruncate.AtEnd;
G2L["a9"]["BorderSizePixel"] = 0;
G2L["a9"]["TextSize"] = 16;
G2L["a9"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["a9"]["TextScaled"] = true;
G2L["a9"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["a9"]["FontFace"] = Font.new([[rbxassetid://12187365364]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["a9"]["TextColor3"] = Color3.fromRGB(255, 81, 81);
G2L["a9"]["BackgroundTransparency"] = 1;
G2L["a9"]["Size"] = UDim2.new(0, 0, 1, 0);
G2L["a9"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["a9"]["Text"] = [[0]];
G2L["a9"]["LayoutOrder"] = 2;
G2L["a9"]["Name"] = [[value]];


-- StarterGui.GoonHub.Main.panel.debug.errors.value.flex
G2L["aa"] = Instance.new("UIFlexItem", G2L["a9"]);
G2L["aa"]["Name"] = [[flex]];
G2L["aa"]["FlexMode"] = Enum.UIFlexMode.Fill;


-- StarterGui.GoonHub.Main.panel.debug.errors.value.size
G2L["ab"] = Instance.new("UITextSizeConstraint", G2L["a9"]);
G2L["ab"]["Name"] = [[size]];
G2L["ab"]["MaxTextSize"] = 13;


-- StarterGui.GoonHub.Main.panel.debug.warnings
G2L["ac"] = Instance.new("Frame", G2L["a1"]);
G2L["ac"]["BorderSizePixel"] = 0;
G2L["ac"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["ac"]["Size"] = UDim2.new(0.06, 0, 1, 0);
G2L["ac"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["ac"]["Name"] = [[warnings]];
G2L["ac"]["LayoutOrder"] = 2;
G2L["ac"]["BackgroundTransparency"] = 1;


-- StarterGui.GoonHub.Main.panel.debug.warnings.list
G2L["ad"] = Instance.new("UIListLayout", G2L["ac"]);
G2L["ad"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
G2L["ad"]["Padding"] = UDim.new(0, 8);
G2L["ad"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
G2L["ad"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
G2L["ad"]["Name"] = [[list]];
G2L["ad"]["FillDirection"] = Enum.FillDirection.Horizontal;


-- StarterGui.GoonHub.Main.panel.debug.warnings.icon
G2L["ae"] = Instance.new("ImageLabel", G2L["ac"]);
G2L["ae"]["BorderSizePixel"] = 0;
G2L["ae"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["ae"]["ImageColor3"] = Color3.fromRGB(255, 255, 81);
G2L["ae"]["Image"] = [[rbxassetid://71503984286896]];
G2L["ae"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["ae"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["ae"]["BackgroundTransparency"] = 1;
G2L["ae"]["LayoutOrder"] = 1;
G2L["ae"]["Name"] = [[icon]];


-- StarterGui.GoonHub.Main.panel.debug.warnings.icon.aspect
G2L["af"] = Instance.new("UIAspectRatioConstraint", G2L["ae"]);
G2L["af"]["Name"] = [[aspect]];


-- StarterGui.GoonHub.Main.panel.debug.warnings.value
G2L["b0"] = Instance.new("TextLabel", G2L["ac"]);
G2L["b0"]["TextWrapped"] = true;
G2L["b0"]["TextTruncate"] = Enum.TextTruncate.AtEnd;
G2L["b0"]["BorderSizePixel"] = 0;
G2L["b0"]["TextSize"] = 16;
G2L["b0"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["b0"]["TextScaled"] = true;
G2L["b0"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["b0"]["FontFace"] = Font.new([[rbxassetid://12187365364]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["b0"]["TextColor3"] = Color3.fromRGB(255, 255, 81);
G2L["b0"]["BackgroundTransparency"] = 1;
G2L["b0"]["Size"] = UDim2.new(0, 0, 1, 0);
G2L["b0"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["b0"]["Text"] = [[0]];
G2L["b0"]["LayoutOrder"] = 2;
G2L["b0"]["Name"] = [[value]];


-- StarterGui.GoonHub.Main.panel.debug.warnings.value.flex
G2L["b1"] = Instance.new("UIFlexItem", G2L["b0"]);
G2L["b1"]["Name"] = [[flex]];
G2L["b1"]["FlexMode"] = Enum.UIFlexMode.Fill;


-- StarterGui.GoonHub.Main.panel.debug.warnings.value.size
G2L["b2"] = Instance.new("UITextSizeConstraint", G2L["b0"]);
G2L["b2"]["Name"] = [[size]];
G2L["b2"]["MaxTextSize"] = 13;


-- StarterGui.GoonHub.Main.panel.debug.memory
G2L["b3"] = Instance.new("Frame", G2L["a1"]);
G2L["b3"]["BorderSizePixel"] = 0;
G2L["b3"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["b3"]["AutomaticSize"] = Enum.AutomaticSize.X;
G2L["b3"]["Size"] = UDim2.new(0.2, 0, 1, 0);
G2L["b3"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["b3"]["Name"] = [[memory]];
G2L["b3"]["LayoutOrder"] = 3;
G2L["b3"]["BackgroundTransparency"] = 1;


-- StarterGui.GoonHub.Main.panel.debug.memory.list
G2L["b4"] = Instance.new("UIListLayout", G2L["b3"]);
G2L["b4"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
G2L["b4"]["Padding"] = UDim.new(0.05, 0);
G2L["b4"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
G2L["b4"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
G2L["b4"]["Name"] = [[list]];
G2L["b4"]["FillDirection"] = Enum.FillDirection.Horizontal;


-- StarterGui.GoonHub.Main.panel.debug.memory.value
G2L["b5"] = Instance.new("TextLabel", G2L["b3"]);
G2L["b5"]["TextWrapped"] = true;
G2L["b5"]["TextTruncate"] = Enum.TextTruncate.AtEnd;
G2L["b5"]["BorderSizePixel"] = 0;
G2L["b5"]["TextSize"] = 14;
G2L["b5"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["b5"]["TextScaled"] = true;
G2L["b5"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["b5"]["FontFace"] = Font.new([[rbxassetid://12187365364]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["b5"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["b5"]["BackgroundTransparency"] = 1;
G2L["b5"]["Size"] = UDim2.new(0, 0, 1, 0);
G2L["b5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["b5"]["Text"] = [[0 MB]];
G2L["b5"]["LayoutOrder"] = 2;
G2L["b5"]["AutomaticSize"] = Enum.AutomaticSize.X;
G2L["b5"]["Name"] = [[value]];


-- StarterGui.GoonHub.Main.panel.debug.memory.value.size
G2L["b6"] = Instance.new("UITextSizeConstraint", G2L["b5"]);
G2L["b6"]["Name"] = [[size]];
G2L["b6"]["MaxTextSize"] = 14;


-- StarterGui.GoonHub.Main.panel.debug.memory.label
G2L["b7"] = Instance.new("TextLabel", G2L["b3"]);
G2L["b7"]["TextWrapped"] = true;
G2L["b7"]["TextTruncate"] = Enum.TextTruncate.AtEnd;
G2L["b7"]["BorderSizePixel"] = 0;
G2L["b7"]["TextSize"] = 14;
G2L["b7"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["b7"]["TextScaled"] = true;
G2L["b7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["b7"]["FontFace"] = Font.new([[rbxassetid://12187365364]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["b7"]["TextColor3"] = Color3.fromRGB(255, 255, 81);
G2L["b7"]["BackgroundTransparency"] = 1;
G2L["b7"]["Size"] = UDim2.new(0, 0, 1, 0);
G2L["b7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["b7"]["Text"] = [[Memory Usage:]];
G2L["b7"]["LayoutOrder"] = 1;
G2L["b7"]["AutomaticSize"] = Enum.AutomaticSize.X;
G2L["b7"]["Name"] = [[label]];


-- StarterGui.GoonHub.Main.panel.debug.memory.label.size
G2L["b8"] = Instance.new("UITextSizeConstraint", G2L["b7"]);
G2L["b8"]["Name"] = [[size]];
G2L["b8"]["MaxTextSize"] = 14;


-- StarterGui.GoonHub.Main.panel.debug.ping
G2L["b9"] = Instance.new("Frame", G2L["a1"]);
G2L["b9"]["BorderSizePixel"] = 0;
G2L["b9"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["b9"]["Size"] = UDim2.new(0.2, 0, 1, 0);
G2L["b9"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["b9"]["Name"] = [[ping]];
G2L["b9"]["LayoutOrder"] = 4;
G2L["b9"]["BackgroundTransparency"] = 1;


-- StarterGui.GoonHub.Main.panel.debug.ping.list
G2L["ba"] = Instance.new("UIListLayout", G2L["b9"]);
G2L["ba"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
G2L["ba"]["Padding"] = UDim.new(0.05, 0);
G2L["ba"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
G2L["ba"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
G2L["ba"]["Name"] = [[list]];
G2L["ba"]["FillDirection"] = Enum.FillDirection.Horizontal;


-- StarterGui.GoonHub.Main.panel.debug.ping.value
G2L["bb"] = Instance.new("TextLabel", G2L["b9"]);
G2L["bb"]["TextWrapped"] = true;
G2L["bb"]["TextTruncate"] = Enum.TextTruncate.AtEnd;
G2L["bb"]["BorderSizePixel"] = 0;
G2L["bb"]["TextSize"] = 14;
G2L["bb"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["bb"]["TextScaled"] = true;
G2L["bb"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["bb"]["FontFace"] = Font.new([[rbxassetid://12187365364]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["bb"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["bb"]["BackgroundTransparency"] = 1;
G2L["bb"]["Size"] = UDim2.new(0, 0, 1, 0);
G2L["bb"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["bb"]["Text"] = [[0 ms]];
G2L["bb"]["LayoutOrder"] = 2;
G2L["bb"]["AutomaticSize"] = Enum.AutomaticSize.X;
G2L["bb"]["Name"] = [[value]];


-- StarterGui.GoonHub.Main.panel.debug.ping.value.size
G2L["bc"] = Instance.new("UITextSizeConstraint", G2L["bb"]);
G2L["bc"]["Name"] = [[size]];
G2L["bc"]["MaxTextSize"] = 14;

-- StarterGui.GoonHub.Main.panel.debug.ping.label
G2L["bd"] = Instance.new("TextLabel", G2L["b9"]);
G2L["bd"]["TextWrapped"] = true;
G2L["bd"]["TextTruncate"] = Enum.TextTruncate.AtEnd;
G2L["bd"]["BorderSizePixel"] = 0;
G2L["bd"]["TextSize"] = 14;
G2L["bd"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["bd"]["TextScaled"] = true;
G2L["bd"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["bd"]["FontFace"] = Font.new([[rbxassetid://12187365364]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["bd"]["TextColor3"] = Color3.fromRGB(255, 255, 81);
G2L["bd"]["BackgroundTransparency"] = 1;
G2L["bd"]["Size"] = UDim2.new(0, 0, 1, 0);
G2L["bd"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["bd"]["Text"] = [[Avg. Ping:]];
G2L["bd"]["LayoutOrder"] = 1;
G2L["bd"]["AutomaticSize"] = Enum.AutomaticSize.X;
G2L["bd"]["Name"] = [[label]];


-- StarterGui.GoonHub.Main.panel.debug.ping.label.size
G2L["be"] = Instance.new("UITextSizeConstraint", G2L["bd"]);
G2L["be"]["Name"] = [[size]];
G2L["be"]["MaxTextSize"] = 14;

-- StarterGui.GoonHub.Main.panel.debug.space
G2L["bf"] = Instance.new("Frame", G2L["a1"]);
G2L["bf"]["BorderSizePixel"] = 0;
G2L["bf"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["bf"]["Size"] = UDim2.new(0, 0, 1, 0);
G2L["bf"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["bf"]["Name"] = [[space]];
G2L["bf"]["LayoutOrder"] = 5;
G2L["bf"]["BackgroundTransparency"] = 1;

-- StarterGui.GoonHub.Main.panel.debug.space.flex
G2L["c0"] = Instance.new("UIFlexItem", G2L["bf"]);
G2L["c0"]["Name"] = [[flex]];
G2L["c0"]["FlexMode"] = Enum.UIFlexMode.Fill;

-- StarterGui.GoonHub.Main.panel.debug.fps
G2L["c1"] = Instance.new("TextLabel", G2L["a1"]);
G2L["c1"]["BorderSizePixel"] = 0;
G2L["c1"]["TextSize"] = 14;
G2L["c1"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["c1"]["FontFace"] = Font.new([[rbxassetid://12187365364]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["c1"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["c1"]["BackgroundTransparency"] = 1;
G2L["c1"]["Size"] = UDim2.new(0, 0, 1, 0);
G2L["c1"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["c1"]["Text"] = [[FPS: 0.0/s]];
G2L["c1"]["LayoutOrder"] = 6;
G2L["c1"]["AutomaticSize"] = Enum.AutomaticSize.X;
G2L["c1"]["Name"] = [[fps]];

-- StarterGui.GoonHub.Main.panel.debug.region
G2L["c2"] = Instance.new("TextLabel", G2L["a1"]);
G2L["c2"]["BorderSizePixel"] = 0;
G2L["c2"]["TextSize"] = 14;
G2L["c2"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["c2"]["FontFace"] = Font.new([[rbxassetid://12187365364]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["c2"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["c2"]["BackgroundTransparency"] = 1;
G2L["c2"]["Size"] = UDim2.new(0, 0, 1, 0);
G2L["c2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["c2"]["Text"] = [[Region: N/A]];
G2L["c2"]["LayoutOrder"] = 7;
G2L["c2"]["AutomaticSize"] = Enum.AutomaticSize.X;
G2L["c2"]["Name"] = [[region]];


-- StarterGui.GoonHub.Main.Corner
G2L["c3"] = Instance.new("UICorner", G2L["2"]);
G2L["c3"]["Name"] = [[Corner]];
G2L["c3"]["CornerRadius"] = UDim.new(0, 18);


-- StarterGui.GoonHub.Main.MobileFullScreenPadding
G2L["c4"] = Instance.new("UIPadding", G2L["2"]);
G2L["c4"]["Name"] = [[MobileFullScreenPadding]];


-- StarterGui.GoonHub.Main.Stroke
G2L["c5"] = Instance.new("UIStroke", G2L["2"]);
G2L["c5"]["Transparency"] = 0.75;
G2L["c5"]["Thickness"] = 2;
G2L["c5"]["Name"] = [[Stroke]];


return {
	Objects = G2L,
	Root = G2L["1"],
	Main = G2L["2"],
	Scale = G2L["3"],
	Controls = G2L["5"],
	DragHandle = G2L["6"],
	ResizeHandle = G2L["b"],
	Content = G2L["10"],
	Screen = G2L["11"],
	PageLayout = G2L["14"],
	Sidebar = G2L["16"],
	Navigation = G2L["4d"],
	HomeButton = G2L["4e"],
	HomeScreenValue = G2L["53"],
	CloseButton = G2L["72"],
	ReturnButton = G2L["7c"],
	NavButton = G2L["80"],
	WindowButton = G2L["8a"],
	FullscreenButton = G2L["94"],
	DebugBar = G2L["a1"],
	FpsLabel = G2L["c1"],
	RegionLabel = G2L["c2"],
}
