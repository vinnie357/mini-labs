# nix for docker images


- nix-with-dockerfiles

    `thank you` [MH](https://github.com/mitchellh)

    https://mitchellh.com/writing/nix-with-dockerfiles


    ```bash
    git clone https://github.com/mitchellh/flask-nix-example.git

    cd flask-nix-example

    ## run with features
    nix --extra-experimental-features "nix-command flakes" build


    # or
    if ! grep -Fxq "experimental-features = nix-command flakes" /etc/nix/nix.conf
    then
        echo "experimental-features = nix-command flakes" | sudo tee -a /etc/nix/nix.conf
    fi

    # run the app
    result/bin/app

    # make some changes
    cat << 'EOF' > src/app.py
    import os
    from flask import Flask

    app = Flask(__name__)

    @app.route("/")
    def hello_world():
        return "<p>Hello, World!</p>"

    def main():
        host = os.environ.get('HOST', '0.0.0.0')
        port = int(os.environ.get('PORT', 5000))
        app.run(host=host, port=port)

    if __name__ == '__main__':
        main()
    EOF

    # docker build
    docker build -t flask-example:dev .

    # inspect the image
    docker image list | grep flask-example
    docker inspect flask-example:dev

    # test the new image
    PORT=8080
    docker run -p $PORT:$PORT -e PORT=8080 -e HOST=0.0.0.0 --rm flask-example:dev

    ```

- nix without docker

