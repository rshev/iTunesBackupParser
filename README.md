# iTunesBackupParser
A playground to play with iTunes backups plists.

Currently can parse Info.plist of iTunes backup and show:
- List of Apple IDs with their corresponding iTunes PurchaserIDs
- List of apps installed with each Apple ID

Sample output:
```
▿ 2 key/value pairs
  ▿ (2 elements)
    - key: "fancyid@icloud.com"
    - value: 1325786074
  ▿ (2 elements)
    - key: "anotherappleid@me.com"
    - value: 10115331978
▿ 2 key/value pairs
  ▿ (2 elements)
    - key: "fancyid@icloud.com"
    ▿ value: 1 element
      - "Dicty - universal dictionary shell"
  ▿ (2 elements)
    - key: "anotherappleid@me.com"
    ▿ value: 3 elements
      - "7 Minute TV Workout"
      - "Ad Block Multi"
      - "Monzo Bank"
```

Served its purpose for me (radaring really hard to reproduce bug to Apple) so never went to wrap it up as a console utility.
If you're fancy to do this, PRs are most welcome.
