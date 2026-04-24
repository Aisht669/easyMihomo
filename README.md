一个简单的交互式脚本，用于管理 mihomo（Clash Meta）配置文件。

A simple interactive script to manage mihomo (Clash Meta) configuration files.

---

## 功能 / Features

- 自动检测配置文件是否存在 / Auto-detect if config file exists
- 显示多个订阅源的最后修改时间 / Show Last-Modified time of multiple subscription sources
- 交互式选择要下载的配置 / Interactive selection of config to download
- 一键启动 mihomo / One-click launch mihomo

---

## 使用方法 / Usage

### 1. 下载脚本 / Download the script

```bash
git clone https://github.com/YOUR_USERNAME/mihomo-updater.git
cd mihomo-updater
```

### 2. 编辑配置文件 / Edit configuration

编辑 `run-mihomo.sh`，修改顶部的 URL 列表：

Edit `run-mihomo.sh`, modify the URL list at the top:

```sh
URLS="
https://example.com/config1.yaml
https://example.com/config2.yaml
https://example.com/config3.yaml
"
```

### 3. 运行 / Run

```bash
chmod +x run-mihomo.sh
./run-mihomo.sh
```

---

## 运行逻辑 / Flow

```
配置文件不存在?
│
├─ 是 → 列出所有配置时间 → 选择下载 → 启动 mihomo
│        Config not exists?
│        ├─ Yes → List all config times → Select download → Launch mihomo
│
│
└─ 否 → 菜单
         ├─ 1) 直接运行 / Direct run
         └─ 2) 更新配置 / Update config → 列出时间 → 选择下载 → 启动
                                 → List times → Select download → Launch
```

---

## 输出示例 / Output Example

```
配置文件已存在: ./config.yaml

========================================
请选择操作 / Select action:
========================================
1) 直接运行 mihomo / Run mihomo directly
2) 更新配置 / Update config
========================================
请输入选择 / Enter choice (1-2): 2

========================================
请选择要下载的配置文件 / Select config to download:
========================================
1) 2026-03-30 10:40:32
2) 2026-04-01 00:03:06
3) 2026-04-05 14:33:55

请输入选择 / Enter choice (1-3): 3
正在下载配置 3... / Downloading config 3...
下载成功！ / Download successful!

正在启动 mihomo... / Starting mihomo...
配置文件: ./config.yaml
按 Ctrl+C 停止 / Press Ctrl+C to stop
========================================
```

---

## 依赖 / Requirements

- `curl` - 下载配置文件 / Download config files
- `nix-shell -p mihomo` - 运行 mihomo / Run mihomo
- `awk` - 日期格式转换 / Date format conversion

---
---

## 许可 / License

MIT License
