# setting timeouts for the ftp server to prevent it from timing out before client start sending requests
import pyftpdlib.handlers
pyftpdlib.handlers.PassiveDTP.timeout = 12000
