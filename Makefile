
run: stop start exec

start:
	docker run -it -d -v /var/run/docker.sock:/var/run/docker.sock -v $$(pwd):/work -v /mnt/c/Users/bryan/.ssh:/root/.ssh -v $$HOME:/host -v aws:/root/.aws -v /mnt/c/Users/bryan:/bryan -w /work --name pawst bryandollery/pawst

exec:
	docker exec -it pawst bash || true

stop:
	docker rm -f pawst 2> /dev/null || true

fmt:
	terraform fmt -recursive

plan:
	terraform plan -out plan.out -var-file=terraform.tfvars

apply:
	terraform apply plan.out 

up:
	terraform apply -auto-approve -var-file=terraform.tfvars

down:
	terraform destroy -auto-approve 

init:
	rm -rf .terraform ssh
	mkdir ssh
	terraform init
	ssh-keygen -t rsa -f ./ssh/id_rsa -q -N ""	
