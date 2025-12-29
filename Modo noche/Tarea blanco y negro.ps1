# atajo.ps1
# Script para presionar Win + Ctrl + C

Add-Type @"
using System;
using System.Runtime.InteropServices;

public class KeyPresser {
    [DllImport("user32.dll")]
    public static extern void keybd_event(byte bVk, byte bScan, uint dwFlags, int dwExtraInfo);
    
    public const int KEYEVENTF_KEYDOWN = 0;
    public const int KEYEVENTF_KEYUP = 2;
    
    // Códigos de teclas virtuales
    public const byte VK_LWIN = 0x5B;      // Tecla Windows
    public const byte VK_CONTROL = 0x11;   // Ctrl
    public const byte VK_C = 0x43;         // C
}
"@

# Presionar Win + Ctrl + C
[KeyPresser]::keybd_event([KeyPresser]::VK_LWIN, 0, [KeyPresser]::KEYEVENTF_KEYDOWN, 0)
[KeyPresser]::keybd_event([KeyPresser]::VK_CONTROL, 0, [KeyPresser]::KEYEVENTF_KEYDOWN, 0)
[KeyPresser]::keybd_event([KeyPresser]::VK_C, 0, [KeyPresser]::KEYEVENTF_KEYDOWN, 0)

# Esperar un poco
Start-Sleep -Milliseconds 100

# Soltar todas las teclas
[KeyPresser]::keybd_event([KeyPresser]::VK_C, 0, [KeyPresser]::KEYEVENTF_KEYUP, 0)
[KeyPresser]::keybd_event([KeyPresser]::VK_CONTROL, 0, [KeyPresser]::KEYEVENTF_KEYUP, 0)
[KeyPresser]::keybd_event([KeyPresser]::VK_LWIN, 0, [KeyPresser]::KEYEVENTF_KEYUP, 0)