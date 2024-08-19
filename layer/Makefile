wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
docker run --rm -v "$PWD"/layer:/lambda/opt -v "$PWD":/repo lambci/yumda:2 yum install -y --skip-broken /repo/google-chrome-stable_current_x86_64.rpm
docker run -it -p 9000:8080 html2pdflambda:html2pdf
curl --location 'http://localhost:9000/2015-03-31/functions/function/invocations' \
--header 'Content-Type: application/json' \
--data '{"payload":"hello world!"}'

docker run -it -p 9000:8080 --entrypoint /bin/bash htmltest3
python3.11 -c "import app; app.lambda_handler(None, None)"