<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns="http://purl.oclc.org/dsdl/schematron">
    <ns uri="http://www.tei-c.org/ns/1.0" prefix="tei"/>
    <!-- RJP:2017-10-08: Rules regarding person and place referencing. -->
    <pattern>
        <rule context="tei:body//tei:persName">
            <report test="not(@ref)"> The persName element must have an @ref! </report>
        </rule>
    </pattern>
    <let name="persList" value="//tei:back//tei:listPerson/tei:person/@xml:id"/>
    <pattern>
        <rule context="tei:body//tei:persName/@ref">
            <let name="tokens"
                value="
                    for $i in tokenize(., '\s+')
                    return
                        substring-after($i, '#')"/>
            <assert
                test="
                    every $token in $tokens
                        satisfies $token = $persList"
                > The attribute, after the hashtag (#) must match a defined @xml:id in the
                listPerson in the back of the master XML file! </assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="tei:body//tei:placeName">
            <report test="not(@ref)"> The placeName element must have an @ref! </report>
        </rule>
    </pattern>
    <let name="placeList" value="//tei:back//tei:listPlace/tei:place/@xml:id"/>
    <pattern>
        <rule context="tei:body//tei:placeName/@ref">
            <let name="tokens"
                value="
                    for $i in tokenize(., '\s+')
                    return
                        substring-after($i, '#')"/>
            <assert
                test="
                    every $token in $tokens
                        satisfies $token = $placeList"
                > The attribute, after the hashtag (#) must match a defined @xml:id in the listPlace
                in the back of the master XML file! </assert>
        </rule>
    </pattern>
    <!-- RJP:2017-10-08: Rules regarding currency values. -->
    <pattern>
        <rule context="tei:body//tei:measure[@type = 'currency']">
            <report test="not(@ana)"> Whenever there is currency mentioned you need to indicate the
                value in an @ana attribute. </report>
            <report test="not(@unit)"> Whenever there is currency mentioned you need to indicate the
                value's unit (dollars or £sd) in an @unit attribute. </report>
        </rule>
    </pattern>
    <pattern>
        <rule context="tei:body//tei:measure[@type = 'currency'][@unit = '£sd']/@ana">
            <assert test="matches(., '\d\d_\d\d_\d\d')"> This @ana attribute (because the @unit is
                £sd) must match the following format: ##_##_## </assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="tei:body//tei:measure[@type = 'currency'][@unit = 'dollars']/@ana">
            <assert test="matches(., '\d{1,}\.\d\d')"> This @ana attribute (because the @unit is
                dollars) must match the following format: #.## </assert>
        </rule>
    </pattern>
    <!-- RJP:2017-10-08 Rules regarding basic XML structure -->
    <pattern>
        <rule context="tei:div[@type = 'page']">
            <report test="not(@facs)"> The div element indicating a transcribed/encoded page must
                have a facs attribute pointing to the manuscript image.</report>
            <assert test="count(child::tei:div[@type = 'group']) ge 1"> The div element indicating a
                transcribed/encoded page must have at least one child div @type="group", which
                contains the group of entries for any single account.</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="tei:div[@type = 'group']">
            <!--<assert test="count(child::tei:head) eq 1"> Every div @type="group" must have a child
                head element.</assert>-->
            <assert test="count(child::tei:list[@type = 'entry']) ge 1"> Every div @type="group"
                must have at least one child list @type="entry".</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="tei:body//tei:date">
            <report test="not(@when)"> The date element must have an @when containing the ISO standard date! </report>
        </rule>
    </pattern>
    <pattern>
        <rule context="tei:body//tei:add">
            <report test="not(@resp)"> The add element must have an @resp indicating the editor responsible for this added information! </report>
        </rule>
    </pattern>
    <pattern>
        <rule context="tei:body//tei:supplied">
            <report test="not(@resp)"> The add element must have an @resp indicating the editor responsible for this added information! </report>
        </rule>
    </pattern>
    <pattern>
        <rule context="tei:body//tei:reg">
            <report test="not(@resp)"> The add element must have an @resp indicating the editor responsible for this added information! </report>
        </rule>
    </pattern>

</schema>
