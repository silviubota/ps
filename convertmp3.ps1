Set-PSDebug -Trace 1
Push-Location $args[0]
foreach ($d in Get-ChildItem -Directory -Recurse) {
  $directory = Resolve-Path -Relative $d.FullName
  $dst = $args[1] + "\" + $directory   
  if (!(Test-Path $dst -PathType Container)) {
    New-Item -ItemType Directory -Force -Path $dst
  } 
  foreach ($file in Get-ChildItem -Path $directory) {
    Invoke-Expression "ffmpeg -i `"$($file.FullName)`"-vn -q 4 `"$($dst)\$($file.baseName).mp3`""
  }
}
Pop-Location