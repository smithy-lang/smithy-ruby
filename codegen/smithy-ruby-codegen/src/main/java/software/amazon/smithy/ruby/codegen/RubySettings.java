/*
 * Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
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
import java.util.logging.Logger;
import lombok.Getter;
import lombok.Setter;
import software.amazon.smithy.model.node.ObjectNode;
import software.amazon.smithy.model.shapes.ShapeId;

/**
 * Settings used by {@link RubyCodegenPlugin}.
 */
public final class RubySettings {
    private static final Logger LOGGER = Logger.getLogger(RubySettings.class.getName());

    private static final String SERVICE = "service";
    private static final String MODULE = "module";
    private static final String NAMESPACE = "namespace";
    private static final String GEMSPEC = "gemspec";
    private static final String GEM_NAME = "gemName";
    private static final String GEM_VERSION = "gemVersion";
    private static final String GEM_SUMMARY = "gemSummary";

    @Getter @Setter private ShapeId service;
    @Getter @Setter private String module;
    @Getter @Setter private String namespace;
    @Getter @Setter private String gemName;
    @Getter @Setter private String gemVersion;
    @Getter @Setter private String gemSummary;

    /**
     * Create a settings object from a configuration object node.
     *
     * @param config Config object to load.
     * @return Returns the extracted settings.
     */
    public static RubySettings from(ObjectNode config) {
        RubySettings settings = new RubySettings();
        config.warnIfAdditionalProperties(
                Arrays.asList(SERVICE, MODULE, NAMESPACE, GEMSPEC, GEM_NAME, GEM_VERSION, GEM_SUMMARY));

        settings.setService(config.expectStringMember(SERVICE).expectShapeId());
        // module and namespace
        settings.setModule(config.expectStringMember(MODULE).getValue());
        // config.getStringMember(NAMESPACE).ifPresent(s -> settings.setNamespace(s.getValue()));
        // required gemspec values
        ObjectNode gemspec = config.expectObjectMember(GEMSPEC);
        settings.setGemName(gemspec.expectStringMember(GEM_NAME).getValue());
        settings.setGemVersion(gemspec.expectStringMember(GEM_VERSION).getValue());
        settings.setGemSummary(gemspec.expectStringMember(GEM_SUMMARY).getValue());

        LOGGER.info("Created Ruby Settings: " + settings.toString());

        return settings;
    }
}
