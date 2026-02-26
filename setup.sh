#Lệnh là sudo bash setup.sh nhé

#Nhớ chạy quyền quản trị
#!/usr/bin/env bash
set -euo pipefail #ko cần quan tâm cái này nhó

# Usage: sudo bash scripts/bootstrap_rpi.sh [--build-ffmpeg]
echo "1. Cập nhật hệ thống xíu"
apt update
apt upgrade -y

echo "2. Cài đặt các gói cần dùng trong dự án nha"
DEBS=(
    # Bộ công cụ cơ bản 
    build-essential cmake pkg-config git # cái này là bộ công cụ biên dịch và quản lý project và lấy source
    yasm nasm                            # assembler dùng cho code hiệu năng cao (x264 và x265)
    autoconf automake libtool            # hệ thống build GNU autotool 
    btop
    #Thư viện dành cho hệ thống
    libv4l-dev                           # hỗ trợ Video4Linux(camera, codec)
    libdrm-dev libudev-dev               # quản lý thiết bị GPU driver
    libssl-dev ca-certificates           # Bảo mật, HTTPS
    #Thư viện ngoài 
    ffmpeg                               #Thư viện xử lý ảnh 
    v4l-utils                            
    libzbar-dev zbar-tools               #thư viện zbar hỗ trợ cho QR, bar code 
    libcamera-dev                        
    libgtk-3-dev libcairo2-dev libglib2.0-dev # GTK 
    libavcodec-dev libgdk-pixbuf-xlib-2.0-dev libavformat-dev libavutil-dev libswscale-dev libavdevice-dev #Thư viện chính của ffmpeg
)

apt install -y "${DEBS[@]}"

echo "5) Kiểm tra lại"
ffmpeg -version || true
zbarimg --version || true
v4l2-ctl --list-formats-ext -d /dev/video0 || true

echo "Đã cài xong tự reboot lại nhé"