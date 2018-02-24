package net.matthiasauer.utils.di;

interface DependencyDefinition {
    function addTo(applicationContext:ApplicationContext) : Void;
}