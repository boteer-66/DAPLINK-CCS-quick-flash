# MSPM0 Flash Tool

CCS Theia + DAPLink + OpenOCD 零元烧录 MSPM0G3507 最小核心板。

## 接线

| DAPLink | MSPM0G3507 核心板 |
|------|------|
| 3.3V | 3V3 |
| GND | GND |
| SWCLK | CLK |
| SWDIO | DIO |



## 前提

1. 安装 [CCS Theia](https://www.ti.com/tool/download/CCSTUDIO-THEIA)，只勾 MSPM0 组件
2. 下载 [OpenOCD 预发布版](https://github.com/openocd-org/openocd/releases)，解压到 `D:\openocd`
3. CCS 编译工程生成 `.out` 文件

## 快速开始

1. 把 `flash.bat` 放到你所有工程的**根目录**（如 `D:\TI`）
2. （可选）把该目录加入系统 PATH——以后任何位置直接敲 `flash`
3. CCS 点锤子编译
4. 终端敲 `flash`

```cmd
flash              # 自动搜索当前目录下最新的 .out 并烧录
flash 工程名        # 指定工程名烧录
```

## 故障排查

| 现象 | 原因 | 解决 |
|------|------|------|
| `命令语法不正确` | 文件编码不对，夹了 BOM 或隐藏字符 | 右键 → 记事本打开 → 另存为 → 编码选 **ANSI** → 覆盖保存 |
| `[ERR] No .out found` | `.out` 不在预期路径 | 跑 `dir /s /b *.out` 看实际路径；把脚本放到工程根目录再跑 |
| `unable to find CMSIS-DAP device` | DAPLink 没插或驱动没装 | 装 CH343 驱动；检查 USB 线 |
| `SWD communication failure` | 接线松动或供电不足 | 核心板单独 Type-C 供电；重插杜邦线；按一下复位再试 |
| LED 按键没反应 | 上下拉配反了 | 配置 `PULL_DOWN` 或反过来判断 `!= 0` |
| `.\flash.bat` 找不到 | 当前目录没有脚本 | 把脚本目录加到 PATH，或 cd 到脚本所在目录再跑 |

## 其他提示

- **OpenOCD 必须放在 `D:\openocd`**，否则改脚本里的路径
- **CCS 只认 XDS110 和 J-Link**，DAPLink 不在 CCS 的下拉列表里——这就是为什么要用 OpenOCD~~
- **脚本不带参数**时，自动从终端当前所在目录往下搜最新的 `.out`
- 如果 `.out` 在 `项目根目录\Debug\` 下而不是 `项目根目录\工程名\Debug\` 下，脚本有备选路径能命中
- 不需要环境变量也能用——cd 到脚本所在目录跑 `.\flash.bat 工程名` 一样行
- 想要能打断点的调试模式？OpenOCD 自带 GDB Server（端口 3333），下期出教程~

## 视频教程

[B站视频链接](https://www.bilibili.com/video/BV1Hp3G6KEB4?vd_source=1f8d7513932890de7bbba0c64edb9cde)
