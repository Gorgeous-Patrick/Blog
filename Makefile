all:
	hugo
	docker build -t patricklidockerhub/portfolio . 
