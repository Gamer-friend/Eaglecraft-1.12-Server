#!/bin/bash

# ─────────────────────────────────────────────────────────────
# CONFIGURATION
# ─────────────────────────────────────────────────────────────
DISCORD_WEBHOOK="https://discord.com/api/webhooks/YOUR_WEBHOOK_ID/YOUR_TOKEN"

# ─────────────────────────────────────────────────────────────
# FUNCTIONS
# ─────────────────────────────────────────────────────────────

# Send Discord notification
send_discord_notification() {
  local message=$1
  curl -H "Content-Type: application/json" \
       -X POST \
       -d "{\"content\": \"$message\"}" \
       "$DISCORD_WEBHOOK"
}

# Print timestamped banner in blue
print_banner() {
  local timestamp
  timestamp=$(date +"%H:%M:%S")
  local blue="\033[34m"
  local reset="\033[0m"

  while IFS= read -r line; do
    echo -e "${blue}[$timestamp] [Server thread/INFO]: $line${reset}"
  done <<'EOF'
╔═════════════════════════════════════════════╗
║  ██████╗ ██╗   ██╗███████╗██╗     ███████╗  ║ 
║  ██╔══██╗██║   ██║██╔════╝██║     ██╔════╝  ║
║  ██║  ██║██║   ██║█████╗  ██║     ███████╗  ║
║  ██║  ██║██║   ██║██╔══╝  ██║     ╚════██║  ║
║  ██████╔╝╚██████╔╝███████╗███████╗███████║  ║
║  ╚═════╝  ╚═════╝ ╚══════╝╚══════╝╚══════╝  ║
╚═════════════════════════════════════════════╝

ANDREW_SHIN.jar >> ☠ ¤ºI·Lùž^œäšžh]³€9=ÜK‡Mƒ†.ÐÜ,M„‡˜†ò·™Ý1ÝNYœ«MŒ.Ë9GÇ×ÛœËuÛIõƒ•v3Æ ûÙg³òð–™‹bùˆ³bù…È‹œ1Ào~lgsvy¾¤ê¡ƒ(«ª>ˆiU‹¢|?×sÄ>½l)b.ŸU.Æq+hÆq+hÆq+h•TíVUÝ—L2“!–Ö2U”V-Ú âZ®Ira…LV2©OàëøXÖåôq|—ûN†Þ¶Ç=eˆÍ»5×_ˆ Ä ›ÐÛH®€ša˜Ò0,YÀé­L™·ÝÆŠ+¯¡x}Û©;åi—½£#¯ÖTg½!›ç‚×hÚKùá/eY÷]¯¦ãšÀp7Âšç/{­Z¥ËåºÀìååkÏým#¸#¶éøŒ[R•µ}ÿ Ø•îbÔÄçHrÜLYaÓÉÝìX>q¤TŽ
EOF
}

# Forward and expose port if needed
ensure_port_forwarded() {
  local port=$1
  if ! gh codespace ports list | grep -q "$port"; then
    echo "🌐 Forwarding port $port..."
    gh codespace ports forward "$port" || echo "⚠️ Failed to forward port $port"
    gh codespace ports visibility "$port:public" || echo "⚠️ Failed to make port $port public"
  else
    echo "🔒 Port $port already forwarded."
  fi
}

# Launch server in background
run_server() {
  local dir=$1
  local jar=$2
  local label=$3
  local logfile="$label.log"

  echo "🔄 Switching to $dir directory... Please Wait For Andrew Shin Eagtek™ To Load... (149/149 ✅)"
  cd "$dir" || { echo "❌ Failed to cd into $dir"; exit 1; }

  if pgrep -f "$jar" > /dev/null; then
    echo "⚠️ $label is already running. Skipping launch..."
  else
    echo "🚀 Launching $label in background..."
    nohup java -jar "$jar" > "$logfile" 2>&1 &
    echo "✅ $label started. Output redirected to $logfile"
    sleep 10
    print_banner
    send_discord_notification "✅ $label is now live on GitHub Codespaces!"
  fi

  cd - > /dev/null
}

# Keep Codespace alive longer
keep_alive() {
  while true; do
    echo "$(date +"%H:%M:%S") — heartbeat"
    sleep 300
  done
}

# ─────────────────────────────────────────────────────────────
# EXECUTION
# ─────────────────────────────────────────────────────────────

# Start keep-alive loop in background
keep_alive &

# Forward ports
ensure_port_forwarded 8081
ensure_port_forwarded 22265

# Launch servers
run_server "server" "server.jar" "Main Server"
run_server "bungee" "bungee.jar" "BungeeCord Server"

# Monitor status
echo "🟢 All servers launched. Monitoring status..."
while true; do
  echo "$(date +"%H:%M:%S") — Main Server: $(pgrep -f server.jar > /dev/null && echo RUNNING || echo STOPPED), BungeeCord: $(pgrep -f bungee.jar > /dev/null && echo RUNNING || echo STOPPED)"
  sleep 60
done
