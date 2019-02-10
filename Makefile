PWD=$(shell pwd)
ROLE_NAME=weareinteractive.pm2
ROLE_PATH=/etc/ansible/roles/$(ROLE_NAME)
TEST_VERSION=ansible --version
TEST_SYNTAX=ansible-playbook -v -i 'localhost,' -c local $(ROLE_PATH)/tests/main.yml --syntax-check
TEST_PLAYBOOK=ansible-playbook -vvvv -i 'localhost,' -c local $(ROLE_PATH)/tests/main.yml
TEST_IDEMPOTENT=$(TEST_PLAYBOOK) | grep -q 'failed=0' && (echo 'Idempotence test: pass' && exit 0) || (echo 'Idempotence test: fail' && exit 1)
TEST_CMD=$(TEST_VERSION); $(TEST_SYNTAX); $(TEST_DEPS); $(TEST_PLAYBOOK); $(TEST_IDEMPOTENT)

ubuntu%: TEST_DEPS=apt-get update && \
	apt-get install -y gnupg python curl && \
	curl -sL http://deb.nodesource.com/setup_11.x | bash - && \
	apt-get install -y nodejs

ubuntu18.04: dist=ubuntu-18.04
ubuntu18.04: .run

ubuntu16.04: dist=ubuntu-16.04
ubuntu16.04: .run

debian%: TEST_DEPS=apt-get update && \
	apt-get install -y gnupg python curl && \
	curl -sL http://deb.nodesource.com/setup_11.x | bash - && \
	apt-get install -y nodejs

debian9: dist=debian-9
debian9: .run

centos%: TEST_DEPS=curl -sL https://rpm.nodesource.com/setup_11.x | bash - && \
	yum install -y nodejs
centos7: dist=centos-7
centos7: .run

.run:
	# RUN: $(TEST_CMD)
	# docker run -it --rm -v $(PWD):$(ROLE_PATH) ansiblecheck/ansiblecheck:$(dist) /bin/bash
	@docker run -it --rm -v $(PWD):$(ROLE_PATH) ansiblecheck/ansiblecheck:$(dist) /bin/bash -c "$(TEST_CMD)"
