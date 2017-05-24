

APP_VERSION  := 0.9.0
BUILD_NUMBER ?= 0

clean:
	-rm -f aws-scripts-mon*.deb aws-scripts-mon.control
	@echo make target $@ done

aws-scripts-mon.control: aws-scripts-mon.template
	sed 's/{{Version}}/$(APP_VERSION)-$(BUILD_NUMBER)/' $< > $@
	@echo make target $@ done

debian: aws-scripts-mon.control
	equivs-build aws-scripts-mon.control ;
	which commit-deb2repo.sh && commit-deb2repo.sh -r infrastructure aws-scripts-mon_$(APP_VERSION)-$(BUILD_NUMBER)_*.deb
	-rm aws-scripts-mon.control
	@echo make target $@ done

