ARG PRODUCT_IMAGE
ARG ISCCR_HOMEDIR

FROM $PRODUCT_IMAGE as default
COPY --chown=sagadmin assets/Packages /opt/softwareag/IntegrationServer/packages/

COPY --chown=sagadmin isccr ${ISCCR_HOMEDIR}
COPY --chown=sagadmin licenses/license.txt ${ISCCR_HOMEDIR}/.

RUN chmod +x ${ISCCR_HOMEDIR}/CodeReview.sh 

#EXPOSE 5555

#COPY --chown=sagadmin ./scripts /src/scripts
#RUN chmod +x /src/scripts/*.sh

#ENV JAVA_HOME=/opt/softwareag/jvm/jvm
#ENV PATH=$JAVA_HOME/bin:$PATH

#ENTRYPOINT /src/scripts/Entrypoint.sh
