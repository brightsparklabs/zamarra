##
 # The Zamarra module contains a set of utlities for working with Zthes XML
 # documents
 # _____________________________________________________________________________
 #
 # Created by brightSPARK Labs
 # www.brightsparklabs.com
 ##

require 'rexml/document'
require './zamarra/model/term'
require './zamarra/model/zthes_document'

include Zamarra

module Zamarra

    ##
     # Reads Zthes data and creates models for it
     ##
    class Reader

        ##
         # Reads a Zthes XML file
         #
         # @param xml [String]
         #          path to the XML file to read
         #
         # @return [ZthesDocument] the document created
         ##
        def self.read_zthes_xml(xml)
            xml = File.read(xml)
            document = REXML::Document.new(xml)

            terms = {}
            narrower_terms = []

            document.elements.each('Zthes/term') do |t|
                unless t.elements['termType'].text == "PT"
                    # only process 'Preferred Terms'
                    next
                end

                # create object
                term_id = t.elements['termId'].text
                term_name = t.elements['termName'].text
                term = Model::Term.new term_id, term_name

                # store all children ids
                t.elements.each('relation') do |relation|
                    if relation.elements['relationType'].text == "NT"
                        childId = relation.elements['termId'].text
                        term.add_child_id childId
                        narrower_terms << childId
                    end
                end

                # map id to object
                terms[term_id] = term
            end

            terms.each do |term_id, term|
                term.children_ids.each { |child_id| term.add_child terms[child_id] }
            end

            top_level_terms = terms.reject { |term_id, term| narrower_terms.include? term_id }
            zthes_document = Model::ZthesDocument.new top_level_terms, terms
        end
    end
end
