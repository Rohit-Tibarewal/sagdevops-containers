ARG PRODUCT_IMAGE

FROM $PRODUCT_IMAGE as default
COPY --chown=sagadmin assets/Packages /opt/softwareag/IntegrationServer/packages/
RUN ls -la /opt/softwareag/IntegrationServer/packages/
#RUN mkdir -p /opt/softwareag/IntegrationServer/config/jndi

#EXPOSE 5555

#COPY --chown=sagadmin ./scripts /src/scripts
#RUN chmod +x /src/scripts/*.sh

#ENV JAVA_HOME=/opt/softwareag/jvm/jvm
#ENV PATH=$JAVA_HOME/bin:$PATH

#ENTRYPOINT /src/scripts/Entrypoint.sh
