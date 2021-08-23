      echo ***** Starting backend *****
      echo ***** Initial setup *****
      cd us-congress-pizza-flag-tracker
      export PIP_USER=false
      cp .env.example .env
      python3 -m venv myenv
      source myenv/bin/activate
      echo ***** Installing python *****
      pip3 install -r requirements.txt
      # Below two lines fixes:
      #   ImportError: libGL.so.1: cannot open shared object file: No such file or directory
      # Related to cv2 - can be removed if do away with cv2
      echo ***** Installing libs necessary for cv2 *****
      sudo apt-get update 
      sudo apt-get install ffmpeg libsm6 libxext6  -y
      echo ***** flask init *****
      rm -rf migrations
      DEBUG=True FLASK_APP=app.py flask db init
      echo ***** flask migrate *****
      DEBUG=True FLASK_APP=app.py flask db migrate
      echo ***** flask upgrade *****
      DEBUG=True FLASK_APP=app.py flask db upgrade