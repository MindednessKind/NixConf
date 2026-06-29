#!/usr/bin/env bash
set -euo pipefail

# How many OLD generations to delete
DELETE_COUNT=${1:-3}

PROFILE="/nix/var/nix/profiles/system"

echo "📦 Fetching system generations..."

gens=$(sudo nix-env --list-generations --profile "$PROFILE" \
  | awk '{print $1}' | sort -n)

echo "📊 All generations:"
echo "$gens"

# Take ONLY the oldest N
to_delete=$(echo "$gens" | head -n "$DELETE_COUNT")

echo "🗑️ Will delete the oldest $DELETE_COUNT generations:"
echo "$to_delete"

if [[ -z "$to_delete" ]]; then
  echo "✅ Nothing to delete."
  exit 0
fi

# Delete them
for gen in $to_delete; do
  echo "Deleting generation $gen"
  sudo nix-env --delete-generations "$gen" --profile "$PROFILE"
done

# echo "🧼 Running garbage collection..."
# sudo nix-collect-garbage -d

echo "✅ Done."
