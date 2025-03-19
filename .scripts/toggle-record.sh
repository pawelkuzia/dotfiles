#!/bin/bash

LOCKFILE="/tmp/hyprland_recording.lock"
RECORD_DIR="$HOME/Videos/screencaps"
TIMESTAMP_FILE="/tmp/hyprland_recording_timestamp.txt"
LOG_FILE="/tmp/hyprland_recording.log"
NOTIFY_ICON="camera-video" # Ustalamy wspólną ikonę

# Make sure the directory exists
mkdir -p "$RECORD_DIR"

# Function to log messages
log_message() {
  echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# Check if recording is already running
if pidof wf-recorder >/dev/null; then
  log_message "Stopping recording..."
  pkill wf-recorder
  rm "$LOCKFILE"

  # Get the filename from the saved timestamp
  RECORD_FILE=$(cat "$TIMESTAMP_FILE")
  log_message "Recording file path: $RECORD_FILE"

  # Notification when the recording is finished
  ACTION=$(notify-send "Recording Finished!" \
    "File: $RECORD_FILE" \
    -A "open=📂 Open Folder" \
    -A "play=▶️ Play" \
    -A "gif=📤 Export to GIF" \
    -i "$NOTIFY_ICON" \
    -u normal)

  case "$ACTION" in
  open) xdg-open "$RECORD_DIR" & ;; # Open folder in default file manager
  play) mpv "$RECORD_FILE" & ;;     # Play the video
  gif)
    GIF_FILE="${RECORD_FILE%.mp4}.gif"

    # Check if the MP4 file exists
    if [ ! -f "$RECORD_FILE" ]; then
      notify-send "Error!" "Video file does not exist: $RECORD_FILE" -i "$NOTIFY_ICON"
      exit 1
    fi

    log_message "Converting video to GIF..."
    ffmpeg -i "$RECORD_FILE" -vf "fps=30,scale=800:-1:flags=lanczos" -c:v gif "$GIF_FILE" 2>&1 | tee -a /tmp/ffmpeg_log.txt

    # Check if the conversion was successful
    if [ $? -eq 0 ]; then
      if [ -f "$GIF_FILE" ]; then
        # Notify with buttons for GIF export
        ACTION_GIF=$(notify-send "GIF Ready!" \
          "Saved as: $GIF_FILE" \
          -A "open=📂 Open GIF" \
          -A "folder=📂 Open Folder" \
          -i "$NOTIFY_ICON" \
          -u normal)

        # Handle action for GIF file and folder
        case "$ACTION_GIF" in
        open) xdg-open "$GIF_FILE" & ;;     # Open the GIF
        folder) xdg-open "$RECORD_DIR" & ;; # Open the folder
        esac
      else
        notify-send "Error!" "Conversion to GIF failed. See log: /tmp/ffmpeg_log.txt" -i "$NOTIFY_ICON"
      fi
    else
      notify-send "Error!" "Conversion to GIF failed. See log: /tmp/ffmpeg_log.txt" -i "$NOTIFY_ICON"
    fi
    ;;
  esac

else
  log_message "Starting recording..."

  # Handle fullscreen argument
  if [ "$1" == "fullscreen" ]; then
    log_message "Recording full screen..."
    REGION=$(slurp -o) # Get geometry for full screen via slurp
  else
    # Check region, select it with slurp
    REGION=$(slurp)
  fi

  if [ -z "$REGION" ]; then
    log_message "No region selected for recording. Exiting."
    exit 1
  fi

  # Set the filename for the recording
  TIMESTAMP=$(date +%Y%m%d_%H%M%S)
  RECORD_FILE="$RECORD_DIR/record_${TIMESTAMP}.mp4"

  # Save the filename to a temporary file
  echo "$RECORD_FILE" >"$TIMESTAMP_FILE"

  log_message "Saving recording to: $RECORD_FILE"

  # Start recording with the selected region
  wf-recorder -g "$REGION" -f "$RECORD_FILE" &
  touch "$LOCKFILE"

  # Notification for starting recording with cancel and stop options
  ACTION=$(notify-send "Recording Started!" \
    "Saving to: $RECORD_FILE" \
    -A "stop=🛑 Stop Recording" \
    -A "cancel=❌ Cancel Recording" \
    -i "$NOTIFY_ICON" \
    -u normal -t 3000)

  case "$ACTION" in
  stop)
    # Execute the script again to stop recording
    ~/.scripts/toggle-record.sh
    ;;
  cancel)
    pkill wf-recorder
    rm "$LOCKFILE"
    notify-send "Recording cancelled" "No file saved." -i "$NOTIFY_ICON"
    ;;
  esac
fi
