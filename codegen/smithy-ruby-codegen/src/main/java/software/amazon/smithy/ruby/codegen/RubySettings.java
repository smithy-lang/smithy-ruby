/*
 * Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 * A copy of the License is located at
 *
 *  http://aws.amazon.com/apache2.0
 *
 * or in the "license" file accompanying this file. This file is distributed
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */

package software.amazon.smithy.ruby.codegen;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Logger;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.knowledge.ServiceIndex;
import software.amazon.smithy.model.node.ObjectNode;
import software.amazon.smithy.model.shapes.ServiceShape;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.model.traits.Trait;
import software.amazon.smithy.utils.SmithyUnstableApi;

/**
 * Settings used by {@link DirectedRubyCodegenPlugin}.
 */
@SmithyUnstableApi
public final class RubySettings {
    private static final Logger LOGGER = Logger.getLogger(RubySettings.class.getName());

    private static final String SERVICE = "service";
    private static final String MODULE = "module";
    private static final String GEMSPEC = "gemspec";
    private static final String GEM_NAME = "gemName";
    private static final String GEM_VERSION = "gemVersion";
    private static final String GEM_SUMMARY = "gemSummary";
    private static final String GEM_HOMEPAGE = "gemHomepage";
    private static final String SDK_ID = "sdkId";

    private ShapeId service;
    private String module;
    private String gemName;
    private String gemVersion;
    private String gemSummary;
    private String gemHomepage;
    private String sdkId;

    /**
     * Create a settings object from a configuration object node.
     *
     * @param config Config object to load.
     * @return Returns the extracted settings.
     */
    public static RubySettings from(ObjectNode config) {
        RubySettings settings = new RubySettings();
        config.warnIfAdditionalProperties(
                Arrays.asList(SERVICE, MODULE, GEMSPEC, GEM_NAME, GEM_VERSION, GEM_SUMMARY, SDK_ID));

        settings.setService(config.expectStringMember(SERVICE).expectShapeId());
        // module and namespace
        settings.setModule(config.expectStringMember(MODULE).getValue());
        settings.setSdkId(config.getStringMember(SDK_ID)
                .map(o -> o.getValue()).orElse(settings.getService().getName()));
        // required gemspec values
        ObjectNode gemspec = config.expectObjectMember(GEMSPEC);
        settings.setGemName(gemspec.expectStringMember(GEM_NAME).getValue());
        settings.setGemVersion(gemspec.expectStringMember(GEM_VERSION).getValue());
        settings.setGemSummary(gemspec.expectStringMember(GEM_SUMMARY).getValue());
        // optional gemspec values
        if (gemspec.getMember(GEM_HOMEPAGE).isPresent()) {
            settings.setGemHomepage(gemspec.getStringMember(GEM_HOMEPAGE).get().getValue());
        }

        LOGGER.info("Created Ruby Settings: " + settings);

        return settings;
    }

    /**
     * @return the service to generate for.
     */
    public ShapeId getService() {
        return service;
    }

    /**
     * @param service service to generate for.
     */
    public void setService(ShapeId service) {
        this.service = service;
    }

    /**
     * @return the sdkId of the service.
     */
    public String getSdkId() {
        return sdkId;
    }

    /**
     * @param sdkId sdkId of the service.
     */
    public void setSdkId(String sdkId) {
        this.sdkId = sdkId;
    }

    /**
     * @return module (namespace) to generate in.
     */
    public String getModule() {
        return module;
    }

    /**
     * @param module the module (namespace) to generate in.
     */
    public void setModule(String module) {
        this.module = module;
    }

    /**
     * @return the name of the Gem to generate.
     */
    public String getGemName() {
        return gemName;
    }

    /**
     * @param gemName name of the gem to generate.
     */
    public void setGemName(String gemName) {
        this.gemName = gemName;
    }

    /**
     * @return version of the Gem to generate.
     */
    public String getGemVersion() {
        return gemVersion;
    }

    /**
     * @param gemVersion version of the Gem to generate.
     */
    public void setGemVersion(String gemVersion) {
        this.gemVersion = gemVersion;
    }

    /**
     * @return description of the gem.
     */
    public String getGemSummary() {
        return gemSummary;
    }

    /**
     * @param gemSummary description of the gem.
     */
    public void setGemSummary(String gemSummary) {
        this.gemSummary = gemSummary;
    }

    /**
     * @return homepage of the gem.
     */
    public String getGemHomepage() {
        return gemHomepage;
    }

    /**
     * @param gemHomepage homepage of the gem.
     */
    public void setGemHomepage(String gemHomepage) {
        this.gemHomepage = gemHomepage;
    }

    /**
     * @return default/base dependencies to include.
     */
    public Set<RubyDependency> getBaseDependencies() {
        return (Set.of(RubyDependency.HEARTH));
    }

    /**
     * Resolve a protocol for a service.  The highest priority, supported protocol is used.
     *
     * @param service            service to generate for
     * @param model              model used for generation
     * @param supportedProtocols ordered list of all supported protocols
     * @return the resolved service protocol
     */
    public ShapeId resolveServiceProtocol(
            ServiceShape service, Model model, List<ProtocolGenerator> supportedProtocols) {
        Map<ShapeId, Trait> resolvedProtocols = ServiceIndex.of(model).getProtocols(service);

        ShapeId protocol = supportedProtocols
                .stream()
                .map((pg -> pg.getProtocol()))
                .filter((p) -> resolvedProtocols.containsKey(p))
                .findFirst()
                .orElseThrow(() -> new UnresolvableProtocolException("No protocol generators were found "));
        LOGGER.info("Resolved protocol: " + protocol.getName());
        return protocol;
    }
}


