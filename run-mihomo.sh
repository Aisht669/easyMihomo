!/bin/sh

# mihomo 启动脚本
# 用法: ./run-mihomo.sh

# 配置URL列表
URLS="
https://www.gitlabip.xyz/Alvin9999/PAC/refs/heads/master/backup/img/1/2/ip/clash.meta2/1/config.yaml
https://www.gitlabip.xyz/Alvin9999/PAC/refs/heads/master/backup/img/1/2/ip/clash.meta2/2/config.yaml
https://www.gitlabip.xyz/Alvin9999/PAC/refs/heads/master/backup/img/1/2/ip/clash.meta2/3/config.yaml
"

CONFIG_FILE="./config.yaml"

# 下载指定序号的配置
download_config() {
    num=$1
    i=1
    for url in $URLS; do
        if [ "$i" = "$num" ]; then
            echo "正在下载配置 $num ..."
            curl -sL "$url" -o "$CONFIG_FILE"
            if [ $? -eq 0 ]; then
                echo "下载成功！"
            else
                echo "下载失败！"
                exit 1
            fi
            return
        fi
        i=$((i + 1))
    done
    echo "无效的选择"
    exit 1
}

# 转换日期格式
convert_date() {
    # 输入: 30 Mar 2026 10:40:32
    # 输出: 2026-03-30 10:40
    echo "$1" | awk '{
        months="Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec"
        split($1,m," ")
        split(months,ma," ")
        for(i=1;i<=12;i++) if($2==ma[i]) mm=sprintf("%02d",i)
        print $3"-"mm"-"$1" "$4
    }'
}
# 列出时间并让用户选择
select_and_download() {
    echo "========================================"
    echo "请选择要下载的配置文件:"
    echo "========================================"
    
    i=1
    for url in $URLS; do
        raw_date=$(curl -sI "$url" 2>/dev/null | grep -i "Last-Modified" | awk '{print $3, $4, $5, $6}')
        formatted_date=$(convert_date "$raw_date")
        echo "$i) $formatted_date"
        i=$((i + 1))
    done
    echo ""
    printf "请输入选择 (1-3): "
    read choice
    
    case $choice in
        1|2|3)
            download_config $choice
            ;;
        *)
            echo "无效选择，默认选择最新配置 (3)..."
            download_config 3
            ;;
    esac
}

# 运行 mihomo
run_mihomo() {
    if [ ! -f "$CONFIG_FILE" ]; then
        echo "配置文件不存在!"
        exit 1
    fi
    
    echo "正在启动 mihomo..."
    echo "配置文件: $CONFIG_FILE"
    echo "按 Ctrl+C 停止"
    echo "========================================"
    
    mihomo --run "mihomo -f ./config.yaml"
}

# 主逻辑
if [ -f "$CONFIG_FILE" ]; then
    echo "配置文件已存在: $CONFIG_FILE"
    echo ""
    echo "========================================"
    echo "请选择操作:"
    echo "========================================"
    echo "1) 直接运行 mihomo"
    echo "2) 更新配置"
    echo "========================================"
    printf "请输入选择 (1-2): "
    read choice
    
    case $choice in
        1)
            run_mihomo
            ;;
        2)
            select_and_download
            run_mihomo
            ;;
        *)
            echo "无效选择，默认运行..."
            run_mihomo
            ;;
    esac
else
    echo "配置文件不存在，需要先下载"
    select_and_download
    run_mihomo
fi
