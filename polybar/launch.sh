killall -q polybar
echo "---" | tee -a /tmp/polybar-main.log
polybar main >>/tmp/polybar-main.log 2>&1 &